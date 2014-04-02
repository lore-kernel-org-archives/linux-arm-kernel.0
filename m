From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 2 Apr 2014 19:56:14 +0800
Subject: [PATCH] ARM i.MX51: Add Digi ConnectCore devicetree
In-Reply-To: <1396439100.597907550@f167.i.mail.ru>
References: <1396075706-25384-1-git-send-email-shc_work@mail.ru>
 <1396075706-25384-2-git-send-email-shc_work@mail.ru>
 <20140402113934.GH8753@dragon>
 <1396439100.597907550@f167.i.mail.ru>
Message-ID: <20140402115612.GI8753@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 02, 2014 at 03:45:00PM +0400, Alexander Shiyan wrote:
> Wed, 2 Apr 2014 19:39:35 +0800 ?? Shawn Guo <shawn.guo@freescale.com>:
> > On Sat, Mar 29, 2014 at 10:48:26AM +0400, Alexander Shiyan wrote:
> > > This patch adds support for Digi ConnectCore? i.MX51/Wi-i.MX51 SOM
> > > and basic support for the ConnectCore for i.MX51 JumpStart Kit.
> > > 
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ...
> > > +&weim {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&pinctrl_weim>;
> > > +	status = "okay";
> > > +
> > > +	lan9221: lan9221 at ce000000 {
> > 
> > How does 'ce000000' in the node name comes?
> 
> This is a WEIM CS5 start address.

Hmm, shouldn't the unit-address come from the 'reg' property of the node
somehow?

Shawn
