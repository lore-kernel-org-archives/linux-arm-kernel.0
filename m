From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 6 Dec 2013 16:41:32 -0500
Subject: [PATCH v2 2/5] usb: phy: Add keystone usb phy driver
In-Reply-To: <1386187811-9596-3-git-send-email-w-kwok2@ti.com>
References: <1386187811-9596-1-git-send-email-w-kwok2@ti.com>
 <1386187811-9596-3-git-send-email-w-kwok2@ti.com>
Message-ID: <52A2448C.6010605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 December 2013 03:10 PM, WingMan Kwok wrote:
> Add Keystone platform USB PHY driver support. Current main purpose
> of this driver is to enable the PHY reference clock gate on the
> Keystone SoC. Otherwise it is a nop PHY.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> ---
>  drivers/usb/phy/Kconfig        |   10 +++
>  drivers/usb/phy/Makefile       |    1 +
>  drivers/usb/phy/phy-keystone.c |  142 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 153 insertions(+)
>  create mode 100644 drivers/usb/phy/phy-keystone.c
> 
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
