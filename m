From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 26 Jul 2013 11:59:57 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzJdIHZpZGVvOiBpbXhmYjogQWRkIGZlYXR1cmUgdG8g?=
 =?UTF-8?B?c2V0dXAgUFdNIENvbnRyYXN0IENvbnRyb2wgUmVnaXN0ZXI=?=
In-Reply-To: <20130726073848.GF2737@pengutronix.de>
References: <1374395709-20898-1-git-send-email-shc_work@mail.ru>
 <20130725212053.b39198a8610efc157a91b7be@mail.ru>
 <20130726073848.GF2737@pengutronix.de>
Message-ID: <1374825597.724071106@f170.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, Jul 25, 2013 at 09:20:53PM +0400, Alexander Shiyan wrote:
> > On Thu, 25 Jul 2013 15:38:56 +0200
> > Markus Pargmann <mpa@pengutronix.de> wrote:
> > 
> > > Hi,
> > > 
> > > On Sun, Jul 21, 2013 at 12:35:09PM +0400, Alexander Shiyan wrote:
> > > > This patch adds feature to setup PWM Contrast Control Register.
> > > > This register is used to control the signal output at the contrast pin,
> > > > which controls contrast of the LCD panel.
> > > 
> > > http://www.spinics.net/lists/linux-fbdev/msg10002.html
> > 
> > PWM? I can not understand how the PWM driver will be connected to the
> > framebuffer driver. It is not backlight, this is contrast.
> > Even if we imagine that the driver will be connected through phandle,
> > then we will need to have at least 4! additional parameters in the framebuffer
> > driver: freq source, frequency and active pulse period + phandle to PWM.
> > Is it worth it, given that these parameters should not be adjustable?
> > On my opinion, the only one additional parameter in framebuffer is enough.
> > Thanks.
> 
> Why should the contrast of a display not be adjustable?

I still can not understand the interface through which it can be changed.
Same as how the default settings can be passed to the framebuffer driver.

---
