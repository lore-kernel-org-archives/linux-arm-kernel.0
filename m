From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 02 Apr 2014 16:06:47 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNIGkuTVg1MTogQWRkIERpZ2kgQ29ubmVjdENvcmUg?=
 =?UTF-8?B?ZGV2aWNldHJlZQ==?=
In-Reply-To: <20140402115612.GI8753@dragon>
References: <1396075706-25384-1-git-send-email-shc_work@mail.ru>
 <1396439100.597907550@f167.i.mail.ru>
 <20140402115612.GI8753@dragon>
Message-ID: <1396440407.634334403@f167.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wed, 2 Apr 2014 19:56:14 +0800 ?? Shawn Guo <shawn.guo@freescale.com>:
> On Wed, Apr 02, 2014 at 03:45:00PM +0400, Alexander Shiyan wrote:
> > Wed, 2 Apr 2014 19:39:35 +0800 ?? Shawn Guo <shawn.guo@freescale.com>:
> > > On Sat, Mar 29, 2014 at 10:48:26AM +0400, Alexander Shiyan wrote:
> > > > This patch adds support for Digi ConnectCore? i.MX51/Wi-i.MX51 SOM
> > > > and basic support for the ConnectCore for i.MX51 JumpStart Kit.
> > > > 
> > > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ...
> > > > +&weim {
> > > > +	pinctrl-names = "default";
> > > > +	pinctrl-0 = <&pinctrl_weim>;
> > > > +	status = "okay";
> > > > +
> > > > +	lan9221: lan9221 at ce000000 {
> > > 
> > > How does 'ce000000' in the node name comes?
> > 
> > This is a WEIM CS5 start address.
> 
> Hmm, shouldn't the unit-address come from the 'reg' property of the node
> somehow?

I'm not sure. Here is the real physical address of the device, in the case of
using an address from the "reg", we get zero address.

Just imagine, that we have a second LAN chip on the start of CS4.
Two identical devices?

---
