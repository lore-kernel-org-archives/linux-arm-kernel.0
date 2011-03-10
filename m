From: ben-i2c@fluff.org (Ben Dooks)
Date: Thu, 10 Mar 2011 13:34:54 +0000
Subject: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
In-Reply-To: <alpine.DEB.2.00.1103100609080.15132@utopia.booyaka.com>
References: <1299245123-23444-1-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com>
	<4D775418.6050105@ti.com>
	<alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com>
	<4D78CAFC.4080502@ti.com>
	<alpine.DEB.2.00.1103100609080.15132@utopia.booyaka.com>
Message-ID: <20110310133454.GF15795@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2011 at 06:17:02AM -0700, Paul Walmsley wrote:
> Hi Ben,
> 
> On Thu, 10 Mar 2011, Rajendra Nayak wrote:
> 
> > On Thursday 10 March 2011 05:48 PM, Paul Walmsley wrote:
> > > This patch is currently breaking boot on OMAP4430 ES2.0 Pandaboard,
> > > so I've dropped it from the integration branch until it can be
> > > debugged.  Could you check it, please?
> > > 
> > > The tag "integration-2.6.39-20110310-008" of
> > > git://git.pwsan.com/linux-integration boots fine; it's got everything
> > > but this patch.  Then when this patch is applied, I2C problems show
> > > up, and root (on MMC) doesn't mount.
> > 
> > Looks like you are missing this patch which should fix the i2c
> > timeouts..
> 
> Do you think you'll merge this patch:
> 
>    http://marc.info/?l=linux-omap&m=129924561819873&w=2
> 
> during the 2.6.39 window?  If so, then I'll add Rajendra's clockdomain 
> patch back in to my 2.6.39 queue here; it seems to depend on the I2C 
> driver patch.

see
http://git.fluff.org/gitweb?p=bjdooks/linux.git;a=shortlog;h=refs/heads/for-2639-rc7/i2c-fixes

awaiting linus.

> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
