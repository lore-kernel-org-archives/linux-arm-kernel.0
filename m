From: balbi@ti.com (Felipe Balbi)
Date: Mon, 23 Feb 2015 09:30:19 -0600
Subject: [resend PATCH v3 4/4] usb: phy: add phy-hi6220-usb
In-Reply-To: <20150211091031.GR16955@sapphire.tkos.co.il>
References: <1423559404-13058-1-git-send-email-zhangfei.gao@linaro.org>
 <1423559404-13058-5-git-send-email-zhangfei.gao@linaro.org>
 <20150210144807.GC16711@saruman.tx.rr.com>
 <BN3PR0301MB0849FB28B1DAF7BEB5F3BE7881250@BN3PR0301MB0849.namprd03.prod.outlook.com>
 <20150211091031.GR16955@sapphire.tkos.co.il>
Message-ID: <20150223153019.GE32701@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 11:10:31AM +0200, Baruch Siach wrote:
> Hi Peter, Felipe,
> 
> > > new drivers only on drivers/phy/, sorry.
> > 
> > This driver has many USB dependencies, like otg, gadget. I don't know it
> > can use generic phy currently.
> 
> I would like to remind you the thread at 
> http://thread.gmane.org/gmane.linux.kernel/1858137. I have a USB PHY driver 
> here that depends on notify_connect/notify_disconnect, which are not currently 
> provided by the generic phy infrastructure (drivers/phy/). What would be 
> acceptable solution for this case?

work with Kishon (generic phy maintainer) to add missing pieces you
need.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150223/15f8f2d8/attachment.sig>
