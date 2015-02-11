From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 11 Feb 2015 11:10:31 +0200
Subject: [resend PATCH v3 4/4] usb: phy: add phy-hi6220-usb
In-Reply-To: <BN3PR0301MB0849FB28B1DAF7BEB5F3BE7881250@BN3PR0301MB0849.namprd03.prod.outlook.com>
References: <1423559404-13058-1-git-send-email-zhangfei.gao@linaro.org>
 <1423559404-13058-5-git-send-email-zhangfei.gao@linaro.org>
 <20150210144807.GC16711@saruman.tx.rr.com>
 <BN3PR0301MB0849FB28B1DAF7BEB5F3BE7881250@BN3PR0301MB0849.namprd03.prod.outlook.com>
Message-ID: <20150211091031.GR16955@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter, Felipe,

> > new drivers only on drivers/phy/, sorry.
> 
> This driver has many USB dependencies, like otg, gadget. I don't know it
> can use generic phy currently.

I would like to remind you the thread at 
http://thread.gmane.org/gmane.linux.kernel/1858137. I have a USB PHY driver 
here that depends on notify_connect/notify_disconnect, which are not currently 
provided by the generic phy infrastructure (drivers/phy/). What would be 
acceptable solution for this case?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
