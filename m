From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 7 May 2015 10:15:42 +0200
Subject: [PATCH v12] clk: Add common clock support for Mediatek MT8135
 and MT8173
In-Reply-To: <20150506055410.GC10871@codeaurora.org>
References: <1429778143-2074-1-git-send-email-s.hauer@pengutronix.de>
 <20150506055410.GC10871@codeaurora.org>
Message-ID: <20150507081542.GQ6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 05, 2015 at 10:54:10PM -0700, Stephen Boyd wrote:
> On 04/23, Sascha Hauer wrote:
> > The following changes since commit 39a8804455fb23f09157341d3ba7db6d7ae6ee76:
> > 
> >   Linux 4.0 (2015-04-12 15:12:50 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.pengutronix.de/git/sha/linux-2.6.git tags/v4.0-clk-mediatek-v12
> > 
> > for you to fetch changes up to e0ebeaa8a3f4a762cb9c2780170445aad15915d1:
> > 
> >   dt-bindings: ARM: Mediatek: Document devicetree bindings for clock/reset controllers (2015-04-23 10:22:34 +0200)
> > 
> > ----------------------------------------------------------------
> > This patchset contains the initial common clock support for Mediatek SoCs.
> > Mediatek SoC's clock architecture comprises of various PLLs, dividers, muxes
> > and clock gates.
> 
> Applied to clk-next.

Thanks Stephen. I just sent a followup patch for the node names in the
examples.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
