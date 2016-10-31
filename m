From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 31 Oct 2016 01:15:53 +0100
Subject: [PATCH] arm64: dts: mt8173: Fix auxadc node
In-Reply-To: <20161026141500.27105-1-matthias.bgg@gmail.com>
References: <20161026141500.27105-1-matthias.bgg@gmail.com>
Message-ID: <c283e582-68d2-fc9d-956f-bc99d78a5736@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/26/2016 04:15 PM, Matthias Brugger wrote:
> The devicetree node for mt8173-auxadc lacks the clock and
> io-channel-cells property. This leads to a non-working driver.
>
> 	mt6577-auxadc 11001000.auxadc: failed to get auxadc clock
> 	mt6577-auxadc: probe of 11001000.auxadc failed with error -2
>
> Fix these fields to get the device up and running.
>
> Fixes: 748c7d4de46a ("ARM64: dts: mt8173: Add thermal/auxadc device
> nodes")
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---

Applied.
