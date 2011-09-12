From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Mon, 12 Sep 2011 18:59:21 +0300
Subject: [PATCH 0/7] ASoC: ep93xx: convert to use snd_soc_register_card()
In-Reply-To: <20110912101939.GA2953@opensource.wolfsonmicro.com>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
	<4E6D4100.7060007@gmail.com>
	<CABS+qY15T_fR4o4kxBYguXH64wzaCrypJZdaduDDht_9Vqokfg@mail.gmail.com>
	<20110912101939.GA2953@opensource.wolfsonmicro.com>
Message-ID: <20110912155921.GA2657@mwesterb-mobl.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2011 at 11:19:39AM +0100, Mark Brown wrote:
> On Mon, Sep 12, 2011 at 05:55:49AM +0100, Girdwood, Liam wrote:
> 
> > ASoC parts
> 
> > Acked-by: Liam Girdwood <lrg@ti.com>
> 
> I'm happy with them too - they should probably all go in together,
> do folks want me to apply them to ASoC or should we merge via the ARM
> tree?

I'm kind of hoping that Hartley would (N)ACK the mach-ep93xx parts so that
they could be merged via ASoC tree.
