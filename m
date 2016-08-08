From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 8 Aug 2016 15:10:54 +0200
Subject: [PATCH v3,4/5] usb: Add MediaTek USB3 DRD Driver
In-Reply-To: <1465543962-11678-5-git-send-email-chunfeng.yun@mediatek.com>
References: <1465543962-11678-1-git-send-email-chunfeng.yun@mediatek.com>
 <1465543962-11678-5-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <20160808131054.GA25277@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 03:32:41PM +0800, Chunfeng Yun wrote:
> --- /dev/null
> +++ b/drivers/usb/mtu3/Makefile
> @@ -0,0 +1,20 @@
> +
> +#ifeq ($(CONFIG_USB_DEBUG),y)
> +	ccflags-y	+= -DDEBUG
> +#endif

There is no CONFIG_USB_DEBUG in the tree anymore, are you sure you
tested this?  :)

thanks,

greg k-h
