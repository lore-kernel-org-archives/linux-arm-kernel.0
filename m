From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 02 Nov 2013 00:02:36 +0100
Subject: [PATCH v2 1/4] ARM: EXYNOS: Add support for EXYNOS5410 SoC
In-Reply-To: <527422AC.1050105@gmail.com>
References: <1381763305-7085-1-git-send-email-v.tyrtov@samsung.com>
 <1381763305-7085-2-git-send-email-v.tyrtov@samsung.com>
 <527422AC.1050105@gmail.com>
Message-ID: <2801293.Bp2raaCeuk@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Friday 01 of November 2013 16:52:44 Rob Herring wrote:
> On 10/14/2013 10:08 AM, Vyacheslav Tyrtov wrote:
> > From: Tarek Dakhran <t.dakhran@samsung.com>
> > 
> > EXYNOS5410 is SoC in Samsung's Exynos5 SoC series.
> > Add initial support for this SoC.
> 
> I think this entire patch is mostly unnecessary and this information
> should all be coming from DT. I'll leave it to arm-soc maintainers
> whether they want to accept this addition rather than see some clean-up
> here.

The clean-up here is already in plans, but this is much more than can be 
seen just from this patch, so it needs some time.

> 
> "samsung,exynos5410" does need to be documented though.

Right.

Best regards,
Tomasz
