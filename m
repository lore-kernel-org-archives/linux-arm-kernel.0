From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 18 Jun 2013 11:23:33 +0000 (UTC)
Subject: [PATCH] ARM: OMAP3EVM: Marking omap3_evm_display_init() with
 CONFIG_BROKEN
In-Reply-To: <20130618101139.GJ5523@atomide.com>
References: <1371120838-29599-1-git-send-email-lokeshvutla@ti.com>
 <alpine.DEB.2.02.1306140238270.5514@utopia.booyaka.com>
 <20130618101139.GJ5523@atomide.com>
Message-ID: <alpine.DEB.2.02.1306181122390.4392@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Jun 2013, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [130613 19:44]:
> > On Thu, 13 Jun 2013, Lokesh Vutla wrote:
> > 
> > > On 37xx EVM non-dt boot fails with current mainline,
> > > because of broken GPIO numbering in the board file
> > > that uses hardcoded GPIOs.
> > > 
> > > So marking omap3_evm_display_init() with CONFIG_BROKEN
> > > for now as suggested by Tony as per the below link:
> > > http://www.mail-archive.com/linux-omap at vger.kernel.org/msg90399.html
> > > 
> > > Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com> ---
> > 
> > Tested-by: Paul Walmsley <paul@pwsan.com>
> 
> Thanks applying into omap-for-v3.11/board.

This one is probably a candidate for v3.10-rc...  Otherwise 37xx EVM won't 
boot on v3.10.


- Paul
