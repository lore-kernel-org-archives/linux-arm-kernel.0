From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 09 Aug 2013 19:05:18 +0200
Subject: [PATCHv2 5/5] ARM: dts: Add dt binding documentation for exynos
 rotator
In-Reply-To: <52051B06.7000209@wwwdotorg.org>
References: <1376034053-31910-1-git-send-email-chanho61.park@samsung.com>
 <229348511.e5ckfeMu0d@amdc1227> <52051B06.7000209@wwwdotorg.org>
Message-ID: <4138489.peCz4QHBct@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 of August 2013 10:38:30 Stephen Warren wrote:
> On 08/09/2013 07:15 AM, Tomasz Figa wrote:
> > Hi Chanho,
> > 
> > On Friday 09 of August 2013 16:40:53 Chanho Park wrote:
> >> This patch describes each nodes of rotator and specifies a example how
> >> to bind it.
> >> 
> >> diff --git a/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
> >> 
> >> +* Samsung Image Rotator
> >> +
> >> +Required properties:
> >> +  - compatible : value should be following:
> >> +	(a) "samsung,exynos4210-rotator" for Rotator IP in Exynos4210
> >> +	(b) "samsung,exynos4212-rotator" for Rotator IP in Exynos4212/4412
> >> +	(c) "samsung,exynos5250-rotator" for Rotator IP in Exynos5250
> 
> Is "rotator" the name that the HW documentation uses to refer to this
> block?

Yes, it is. More specifically it is referred to as "Image Rotator".

Best regards,
Tomasz

> If so, those compatible values seem fine. If not, they seem
> slightly too generic for me; perhaps better to use the raw HW block name?
