From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 23 May 2014 15:59:43 +0200
Subject: [PATCH 2/5] Documentation: dt-bindings: document the Armada 375
 USB cluster binding
In-Reply-To: <537F52B0.5030204@ti.com>
References: <1400257376-13251-1-git-send-email-gregory.clement@free-electrons.com>
 <1400257376-13251-2-git-send-email-gregory.clement@free-electrons.com>
 <537F13B2.6070500@ti.com> <20140523132145.GA31314@lunn.ch>
 <20140523133608.GB31314@lunn.ch> <537F52B0.5030204@ti.com>
Message-ID: <20140523135943.GC31314@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 07:22:48PM +0530, Kishon Vijay Abraham I wrote:
> hI,
> 
> On Friday 23 May 2014 07:06 PM, Andrew Lunn wrote:
> >> Do you want one .txt file per driver, or can we combine binding
> >> documentations into one file? There should already be a mvebu-phy.txt,
> >> which contains the sata phy usable on some of the Armada SoC families.
> >> This binding could be appended to it.
> > 
> > Ah. Humm, well! It seems the patch adding the mvebu-phy.txt fell
> > through a crack when adding the driver.
> > 
> > Kishon could you take
> > http://www.spinics.net/lists/devicetree/msg17018.html into your tree?
> > It should of been taken the same time you took the actual driver,
> > http://www.spinics.net/lists/devicetree/msg17011.html into your tree.
> > 
> > I can resend that one missing patch if you want.
> 
> yes please. But it's already too late to go in the next merge window.

Gregory, could you pick it up and append your 375 binding to it? We
can avoid merge conflicts that way.

Thanks
	Andrew
