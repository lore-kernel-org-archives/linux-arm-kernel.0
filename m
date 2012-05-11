From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 11 May 2012 09:52:53 +0200
Subject: [PATCHv9 10/10] ARM: dma-mapping: add support for IOMMU mapper
In-Reply-To: <CAP=VYLr=NeGvppR4ONpnRh=gjCSPdKxYj1HYh_FvadAeUzcbBQ@mail.gmail.com>
References: <1334756652-30830-1-git-send-email-m.szyprowski@samsung.com>
 <1334756652-30830-11-git-send-email-m.szyprowski@samsung.com>
 <CAP=VYLr=NeGvppR4ONpnRh=gjCSPdKxYj1HYh_FvadAeUzcbBQ@mail.gmail.com>
Message-ID: <02e301cd2f4b$11e02f90$35a08eb0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, May 11, 2012 4:09 AM Paul Gortmaker wrote:

> On Wed, Apr 18, 2012 at 9:44 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > This patch add a complete implementation of DMA-mapping API for
> > devices which have IOMMU support.
> 
> Hi Marek,
> 
> It looks like this patch breaks no-MMU builds on ARM, at least
> according to git bisect.  Here is a link to a linux-next failure:
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/6291233/
> 
> arch/arm/mm/dma-mapping.c:726:42: error: 'pgprot_kernel' undeclared
> (first use in this function)
> make[2]: *** [arch/arm/mm/dma-mapping.o] Error 1
> 
> Please have a look, thanks.

Thanks for reporting this issue, I will send a fix in a minute.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
