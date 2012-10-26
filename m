From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 26 Oct 2012 11:54:28 +0200
Subject: [PATCH 3/6] ARM: OMAP2+: Move plat/iovmm.h to
 include/linux/omap-iommu.h
In-Reply-To: <6561916.t72K1L6jg4@avalon>
References: <20121025001913.2082.31062.stgit@muffinssi.local>
 <20121025213935.GD11928@atomide.com>
 <CAK=WgbaCM+MWiHARvdfaGL6w0c7g4_keAm0ADw1vkSeiZ0CZPw@mail.gmail.com>
 <6561916.t72K1L6jg4@avalon>
Message-ID: <CAK=WgbY2-Ajm-2OSheOgLCd4589WKDSqqKjzHkE5Ogyp4puJ3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Fri, Oct 26, 2012 at 11:35 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> That's on my to-do list, as well as porting the OMAP3 ISP driver to videobuf2,
> adding DT support, moving to the common clock framework (when that will be
> available for the OMAP3), supporting missing V4L2 features, ... All this in my
> spare time of course, otherwise it wouldn't be fun, would it ? ;-)

Hmm, seems like a short to-do list ;)

> I would also like to move the tidspbridge to the DMA API, but I think we'll
> need to move step by step there, and using the OMAP IOMMU and IOVMM APIs as an
> intermediate step would allow splitting patches in reviewable chunks. I know
> it's a step backwards in term of OMAP IOMMU usage, but that's in my opinion a
> temporary nuisance to make the leap easier.

Since tidspbridge is in staging I guess it's not a problem, though it
sounds to me like using the correct API in the first place is going to
make less churn.

Thanks,
Ohad.
