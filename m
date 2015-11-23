From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Nov 2015 08:53:04 +0800
Subject: [RESEND PATCH v2 1/2] ARM: imx6: set ahb-burst-config as 0 for USB
In-Reply-To: <1443579437-845-1-git-send-email-peter.chen@freescale.com>
References: <1443579437-845-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20151123005304.GA13744@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 10:17:16AM +0800, Peter Chen wrote:
> After setting ahb burst configuration as 0, we can increase tx/rx
> burst size, it will improve the USB performance
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

Should I queue these patches for v4.4-rc as fixes or v4.5-rc1 as
improvement?

Shawn
