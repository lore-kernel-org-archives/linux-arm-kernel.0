From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Apr 2015 13:55:07 -0700
Subject: [PATCH] ARM: at91/dt: sama5d3 xplained: add phy address for macb1
In-Reply-To: <551E52BC.3040702@atmel.com>
References: <1427792170-13162-1-git-send-email-nicolas.ferre@atmel.com>
 <551E52BC.3040702@atmel.com>
Message-ID: <20150403205507.GH23023@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 03, 2015 at 10:43:40AM +0200, Nicolas Ferre wrote:
> Le 31/03/2015 10:56, Nicolas Ferre a ?crit :
> > After 57a38effa598 (net: phy: micrel: disable broadcast for KSZ8081/KSZ8091)
> > the macb1 interface refuses to work properly because it tries
> > to cling to address 0 which isn't able to communicate in broadcast with
> > the mac anymore. The micrel phy on the board is actually configured
> > to show up at address 1.
> > Adding the phy node and its real address fixes the issue.
> > 
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: Johan Hovold <johan@kernel.org>
> > Cc: <stable@vger.kernel.org> #3.19
> > ---
> 
> Arnd, Olof, Kevin,
> 
> It seems late but, is it possible to queue this patch as a 4.0 fixes?
> 
> Without it, the 10/100 Ethernet on sama5d3 doesn't work if it's not used
> by u-boot previously.

Sure, resend it to arm at kernel.org.


-Olof
