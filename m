From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 30 Sep 2014 04:50:02 +0000
Subject: [PATCH 0/6] ARM: imx_v6_v7_defconfig: enable several usb functions
In-Reply-To: <1412042439-13977-1-git-send-email-peter.chen@freescale.com>
References: <1412042439-13977-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20140930044958.GA2566@arm2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 10:00:33AM +0800, Peter Chen wrote:
> Hi Shawn,
> 
> This series enables several usb functions for both host and device
> mode which are used commonly, and all is built as modules.
> 
> Peter Chen (6):
>   ARM: imx_v6_v7_defconfig: enable USB Ethernet support at host mode
>   ARM: imx_v6_v7_defconfig: enable usb media feature for host mode
>   ARM: imx_v6_v7_defconfig: enable USB audio at host mode
>   ARM: imx_v6_v7_defconfig: enable USB serial at host mode
>   ARM: imx_v6_v7_defconfig: enable USB EHSET driver
>   ARM: imx_v6_v7_defconfig: enable several usb gadgets

Hi Peter,

For defconfig update, we generally combine related changes into one
patch.  So please resend with the patches squashed into one.

Shawn
