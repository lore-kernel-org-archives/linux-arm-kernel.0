From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 25 Oct 2016 14:48:05 +0530
Subject: [PATCH/RFT v2 03/17] ARM: davinci: da8xx: Add USB PHY platform
 declaration
In-Reply-To: <20161024164634.4330-4-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-4-ahaslam@baylibre.com>
Message-ID: <4129f1be-42f6-f182-c8a2-84befe01d298@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 October 2016 10:16 PM, ahaslam at baylibre.com wrote:
> +static struct platform_device da8xx_usb_phy = {
> +	.name		= "da8xx-usb-phy",
> +	.id		= 0,

There is a single phy control in the system for both 1.1 and 2.0 PHYs.
so this can be a singular device (id -1).

Thanks,
Sekhar
