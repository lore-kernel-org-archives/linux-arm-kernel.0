From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 27 Nov 2017 19:12:42 +0100
Subject: [PATCH] ARM: dts: exynos: correct trats2 panel reset line
In-Reply-To: <59887245-ed25-ac1b-3bd4-b72c8fd1dd74@samsung.com>
References: <CGME20171121112435epcas4p25f529481eebd076f0fde78c500b04395@epcas4p2.samsung.com>
 <20171121112424.GA6650@lineageos.org>
 <59887245-ed25-ac1b-3bd4-b72c8fd1dd74@samsung.com>
Message-ID: <20171127181242.qaqlxpj6tnfyf3ei@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 04:06:38PM +0100, Marek Szyprowski wrote:
> Hi Simon,
> 
> On 2017-11-21 12:24, Simon Shields wrote:
> > trats2 uses gpf2-1 as the panel reset GPIO. gpy4-5 was only used
> > on early revisions of the board.
> > 
> > Fixes: 420ae8451a22 ("ARM: dts: exynos4412-trats2: add panel node")
> > Signed-off-by: Simon Shields <simon@lineageos.org>
> 
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> It looks that this has been accidentally copy/pasted from the previous
> dts used for early version of the development board. I've checked the
> Trats2 schematic and indeed gpf2-1 is the correct pin for panel reset
> line.

Thanks for testing.

Thanks, applied.

Best regards,
Krzysztof
