From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jan 2017 00:31:29 +0000
Subject: [PATCH v3 21/24] media: imx: Add MIPI CSI-2 Receiver subdev driver
In-Reply-To: <1483755102-24785-22-git-send-email-steve_longerbeam@mentor.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-22-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170131003129.GP27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 06:11:39PM -0800, Steve Longerbeam wrote:
> +++ b/drivers/staging/media/imx/imx-mipi-csi2.c
...
> +#define DEVICE_NAME "imx6-mipi-csi2"

Why is the device/driver named imx6-mipi-csi2, but the module named
imx-mipi-csi2 - could there be some consistency here please?

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
