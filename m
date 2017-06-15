From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 15 Jun 2017 09:24:08 +0530
Subject: [linux-sunxi] Re: [PATCH 1/2] dmaengine: sun6i: make gate bit in
 sun8i's DMA engines a common quirk
In-Reply-To: <20170614090439.rkdaoo3uqzjqwuxq@flea.lan>
References: <20170605123348.26137-1-icenowy@aosc.io>
 <20170605123348.26137-2-icenowy@aosc.io>
 <20170614083252.GK13020@localhost>
 <AD656BCC-5064-454F-9576-FA59283E0C45@aosc.io>
 <20170614084529.GL13020@localhost>
 <20170614090439.rkdaoo3uqzjqwuxq@flea.lan>
Message-ID: <20170615035407.GM13020@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 11:04:39AM +0200, Maxime Ripard wrote:
> On Wed, Jun 14, 2017 at 02:15:29PM +0530, Vinod Koul wrote:
> > > SoC info is in compatible, so there's no reason to make it a property.
> > 
> > that's why it would need to be optional for the SoC's that needs these..
> 
> There's nothing optional about that behaviour, it's mandatory for the
> SoC that need it, and useless on the SoC that don't.

And why should kernel put strings for each hw behaviour. I am expecting DT
to tell me if this SoC is a special case or not and kernel shall handle
accordingly

> Plus, that would require changing the DT binding, which isn't
> something we can do.

Any reason why bindings can't change..? I though this was support for new
SoC...

-- 
~Vinod
