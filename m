From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 Nov 2016 15:27:26 +0530
Subject: [PATCH v8 2/3] ARM: davinci: da8xx: add usb phy clocks
In-Reply-To: <1477946841-16126-3-git-send-email-david@lechnology.com>
References: <1477946841-16126-1-git-send-email-david@lechnology.com>
 <1477946841-16126-3-git-send-email-david@lechnology.com>
Message-ID: <73e832b5-fbf1-63be-31ed-68a3c5d59282@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 November 2016 02:17 AM, David Lechner wrote:
> Up to this point, the USB phy clock configuration was handled manually in
> the board files and in the usb drivers. This adds proper clocks so that
> the usb drivers can use clk_get and clk_enable and not have to worry about
> the details. Also, the related code is removed from the board files and
> replaced with the new clock registration functions.
> 
> This also removes the #if IS_ENABLED(CONFIG_USB_MUSB_HDRC) around the musb
> declaration and renames the musb platform device so that we can reference
> it from the usb20 clock even if the musb device is not used.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>

Applied to v4.10/soc

Thanks,
Sekhar
