From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Tue, 9 Aug 2016 16:08:57 +0800
Subject: [PATCH v3,4/5] usb: Add MediaTek USB3 DRD Driver
In-Reply-To: <20160808131054.GA25277@kroah.com>
References: <1465543962-11678-1-git-send-email-chunfeng.yun@mediatek.com>
 <1465543962-11678-5-git-send-email-chunfeng.yun@mediatek.com>
 <20160808131054.GA25277@kroah.com>
Message-ID: <1470730137.23281.8.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Mon, 2016-08-08 at 15:10 +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 10, 2016 at 03:32:41PM +0800, Chunfeng Yun wrote:
> > --- /dev/null
> > +++ b/drivers/usb/mtu3/Makefile
> > @@ -0,0 +1,20 @@
> > +
> > +#ifeq ($(CONFIG_USB_DEBUG),y)
> > +	ccflags-y	+= -DDEBUG
> > +#endif
> 
> There is no CONFIG_USB_DEBUG in the tree anymore, are you sure you
> tested this?  :)
> 
Sorry, I just commented it out here and didn't enable it.
I modify it now.

Thank you

> thanks,
> 
> greg k-h
