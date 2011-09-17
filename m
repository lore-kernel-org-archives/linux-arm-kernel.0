From: subaparts@yandex.ru (Alexander Sverdlin)
Date: Sat, 17 Sep 2011 13:58:20 +0200
Subject: [PATCH 3/7] ASoC: edb93xx: convert to use snd_soc_register_card()
In-Reply-To: <20110917065202.GA2759@mwesterb-mobl.ger.corp.intel.com>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
	<0fef3fd00e8cdb8a606f4a81ad4e7f2b7014621c.1315732452.git.mika.westerberg@iki.fi>
	<1316191555.17769.2.camel@r60e>
	<20110917065202.GA2759@mwesterb-mobl.ger.corp.intel.com>
Message-ID: <1316260700.17769.8.camel@r60e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

I've checked mainline linux-next without your patches, it's broken too.
So your patches are not the root cause for that.

On Sat, 2011-09-17 at 09:52 +0300, Mika Westerberg wrote:
> On Fri, Sep 16, 2011 at 06:45:55PM +0200, Alexander Sverdlin wrote:
> > 
> > Have you tried the driver on reference boards?
> 
> No - I don't have any of those.
> 
> > For me it doesn't work any more. Boot messages are ok, as before, but
> > alsa open produces such messages:
> > Jan  1 00:32:19 IPCUn user.err kernel: asoc: can't open platform
> > ep93xx-pcm-audio
> 
> Do you have the first patch ("ASoC: ep93xx-pcm: add MODULE_ALIAS") in this
> series applied? Have you tried whether it still works if you compile
> everything in?
> 
