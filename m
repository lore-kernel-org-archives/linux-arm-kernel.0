From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2015 18:02:11 +0000
Subject: [PATCH 01/13 v2] ARM: add some L220 DT settings
In-Reply-To: <20151116174825.GA14634@rob-hp-laptop>
References: <1445521493-21509-1-git-send-email-linus.walleij@linaro.org>
 <20151116174825.GA14634@rob-hp-laptop>
Message-ID: <20151116180210.GV8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 11:48:25AM -0600, Rob Herring wrote:
> On Thu, Oct 22, 2015 at 03:44:53PM +0200, Linus Walleij wrote:
> > The RealView ARM11MPCore enables parity, eventmon and shared
> > override in the cache controller through its current boardfile,
> > but the code and DT bindings for the ARM L220 is currently
> > lacking the ability to set this up from DT. Add the required
> > bool parameters for parity and shared override, but keep
> > eventmon out of it: this should be enabled by the event
> > monitor code.
> > 
> > Cc: devicetree at vger.kernel.org
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ChangeLog v1->v2:
> > - Drop event monitor setup.
> > - Support both parity enable and disable: could be useful.
> > ---
> >  Documentation/devicetree/bindings/arm/l2cc.txt | 10 ++++++----
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks Rob, this has been in the patch system since the 27th October,
but as DT people hadn't acked it, I didn't take it into my tree.  We're
now too late for this merge window, so it's going to wait for the 4.5
window.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
