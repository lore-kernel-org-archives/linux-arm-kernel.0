From: chanho61.park@samsung.com (Chanho Park)
Date: Thu, 10 Apr 2014 18:57:02 +0900
Subject: [PATCH 02/27] ARM: EXYNOS: Add IO mapping for non-secure SYSRAM of
 Exynos3250
In-Reply-To: <4172202.teSeEmypAU@wuerfel>
References: <1397122124-15690-1-git-send-email-cw00.choi@samsung.com>
 <1397122124-15690-3-git-send-email-cw00.choi@samsung.com>
 <4172202.teSeEmypAU@wuerfel>
Message-ID: <002501cf54a3$38f50d60$aadf2820$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Arnd Bergmann
> Sent: Thursday, April 10, 2014 6:45 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: kgene.kim at samsung.com; t.figa at samsung.com; hyunhee.kim at samsung.com;
> sw0312.kim at samsung.com; linux-kernel at vger.kernel.org;
> yj44.cho at samsung.com; inki.dae at samsung.com; Chanwoo Choi;
> kyungmin.park at samsung.com; linux-samsung-soc at vger.kernel.org
> Subject: Re: [PATCH 02/27] ARM: EXYNOS: Add IO mapping for non-secure
> SYSRAM of Exynos3250
> 
> On Thursday 10 April 2014 18:28:19 Chanwoo Choi wrote:
> >
> > The non-secure SYSRAM is used for secondary CPU bring-up. This patch
> add
> > IO mapping for non-scure SYSRAM.
> >
> > Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> I really don't want to see any further static mappings here. We had the
> same discussion for the previous Exynos chip that was submitted, so
> please
> describe the SYSRAM in DT, and start thinking about the other static
> mappings
> that can be removed.

Sachin already submitted the DT support[1] for SYSRAM area.

[1] : http://www.spinics.net/lists/linux-samsung-soc/msg27647.html

> 
> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
