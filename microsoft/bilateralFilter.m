function filteredIm = bilateralFilter(im, sigma_r, sigma_s)
    [H,W,D] = size(im);

    filteredIm = zeros(H,W,D);
    for i=1:H
        for j=1:W
            minx = max([1,floor(j-3*sigma_s)]);
            maxx = min([W,floor(j+3*sigma_s)]);
            miny = max([1,floor(i-3*sigma_s)]);
            maxy = min([H,floor(i+3*sigma_s)]);
            [X,Y] = meshgrid(minx:maxx,miny:maxy);
            w_s = exp(-((X-j).^2 +(Y-i).^2)/(2*sigma_s*sigma_s));
            w_r = exp(-((im(i,j,:)-im(miny:maxy,minx:maxx,:)).^2)/(2*sigma_r*sigma_r));
            filteredIm(i,j,:) = sum(sum(w_s.*w_r.*im(miny:maxy,minx:maxx,:)))./sum(sum(w_s.*w_r));
        end
    end
end
