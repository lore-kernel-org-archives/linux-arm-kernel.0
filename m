From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 1 Sep 2011 17:02:35 +0300
Subject: [PATCH] iommu: omap_iovmm: support non page-aligned buffers in
	iommu_vmap
In-Reply-To: <201109011559.33491.laurent.pinchart@ideasonboard.com>
References: <1314646569-16738-1-git-send-email-ohad@wizery.com>
	<CAK=Wgbb06Z0_8OKFf6MKjYe+SJN16Mh9PA6z_T+cpSpB9EKHFw@mail.gmail.com>
	<CAK=WgbaOSaKcxmsG2L3G3g+bORvtq4nyzCg9yhA=tTLhsYmh3w@mail.gmail.com>
	<201109011559.33491.laurent.pinchart@ideasonboard.com>
Message-ID: <CAK=WgbY0YTBVbHwHDDa-+8j8d_navvKN=JXFJDpdWp2BX0LFCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 1, 2011 at 4:59 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> It looks good to me.

Thanks.

> I haven't tested it though.

I did, but I always get aligned buffers so my testing is a bit moot. I
can't see how unmap could work without this patch, though, so I'll
squash this and re-post.
