From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun, 18 Sep 2011 10:38:52 +0300
Subject: [PATCH 3/7] ASoC: edb93xx: convert to use snd_soc_register_card()
In-Reply-To: <1316260700.17769.8.camel@r60e>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
	<0fef3fd00e8cdb8a606f4a81ad4e7f2b7014621c.1315732452.git.mika.westerberg@iki.fi>
	<1316191555.17769.2.camel@r60e>
	<20110917065202.GA2759@mwesterb-mobl.ger.corp.intel.com>
	<1316260700.17769.8.camel@r60e>
Message-ID: <20110918073852.GA2625@mwesterb-mobl.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 17, 2011 at 01:58:20PM +0200, Alexander Sverdlin wrote:
> 
> I've checked mainline linux-next without your patches, it's broken too.
> So your patches are not the root cause for that.

Ok thanks.

Still it would be good to find out which causes it to fail. Are you able to
load all the modules manually? Does it work then?
