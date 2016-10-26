From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 26 Oct 2016 15:56:27 +0530
Subject: [PATCH v6 5/5] ARM: DTS: da850: Add usb phy node
In-Reply-To: <1477451211-31979-6-git-send-email-david@lechnology.com>
References: <1477451211-31979-1-git-send-email-david@lechnology.com>
 <1477451211-31979-6-git-send-email-david@lechnology.com>
Message-ID: <d55f19f2-beb3-a681-a6e9-c1d2c303173c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 October 2016 08:36 AM, David Lechner wrote:
> Add a node for the new usb phy driver.

changed this to:

    Add a node for usb phy device. This device
    controls both the USB 1.1 and USB 2.0 PHYs.

mainly because the node is for the device, not the driver.

> 
> Signed-off-by: David Lechner <david@lechnology.com>

Applied to v4.10/dt

Thanks,
Sekhar
