From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 02 Apr 2014 15:45:00 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNIGkuTVg1MTogQWRkIERpZ2kgQ29ubmVjdENvcmUg?=
 =?UTF-8?B?ZGV2aWNldHJlZQ==?=
In-Reply-To: <20140402113934.GH8753@dragon>
References: <1396075706-25384-1-git-send-email-shc_work@mail.ru>
 <1396075706-25384-2-git-send-email-shc_work@mail.ru>
 <20140402113934.GH8753@dragon>
Message-ID: <1396439100.597907550@f167.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wed, 2 Apr 2014 19:39:35 +0800 ?? Shawn Guo <shawn.guo@freescale.com>:
> On Sat, Mar 29, 2014 at 10:48:26AM +0400, Alexander Shiyan wrote:
> > This patch adds support for Digi ConnectCore? i.MX51/Wi-i.MX51 SOM
> > and basic support for the ConnectCore for i.MX51 JumpStart Kit.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
...
> > +&weim {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_weim>;
> > +	status = "okay";
> > +
> > +	lan9221: lan9221 at ce000000 {
> 
> How does 'ce000000' in the node name comes?

This is a WEIM CS5 start address.

---
