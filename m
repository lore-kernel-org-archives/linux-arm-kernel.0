From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 25 Oct 2016 13:40:59 +0530
Subject: [PATCH/RFT v2 02/17] ARM: davinci: da8xx: Add CFGCHIP syscon
 platform declaration.
In-Reply-To: <20161024164634.4330-3-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-3-ahaslam@baylibre.com>
Message-ID: <7f9efe9d-0912-e10a-3e45-24c5d2b455ab@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 October 2016 10:16 PM, ahaslam at baylibre.com wrote:
> From: David Lechner <david@lechnology.com>
> 
> The CFGCHIP registers are used by a number of devices, so using a syscon
> device to share them. The first consumer of this will by the phy-da8xx-usb
> driver.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> [Axel: minor fix: change id to -1]

Can you please clarify this change? There could be other syscon devices
on the chip for other common registers. Why use the singular device-id?

> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>

Thanks,
Sekhar
