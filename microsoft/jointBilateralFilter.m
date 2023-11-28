function filteredIm = jointBilateralFilter(im1, im2, sigma_d, sigma_r)
    [H,W,D] = size(im1);

    filteredIm = zeros(H,W,D);
    for i=1:H
        for j=1:W
            minx = max([1,floor(j-3*sigma_d)]);
            maxx = min([W,floor(j+3*sigma_d)]);
            miny = max([1,floor(i-3*sigma_d)]);
            maxy = min([H,floor(i+3*sigma_d)]);
            [X,Y] = meshgrid(minx:maxx,miny:maxy);
            w_d = exp(-((X-j).^2 +(Y-i).^2)/(2*sigma_d*sigma_d));
            w_r = exp(-((im2(i,j,:)-im2(miny:maxy,minx:maxx,:)).^2)/(2*sigma_r*sigma_r));
            filteredIm(i,j,:) = sum(sum(w_d.*w_r.*im1(miny:maxy,minx:maxx,:)))./sum(sum(w_d.*w_r));
        end
    end
end