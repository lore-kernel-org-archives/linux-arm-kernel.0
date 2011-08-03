From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 3 Aug 2011 14:23:35 +0900
Subject: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
In-Reply-To: <s5h4o1zsn6o.wl%tiwai@suse.de>
References: <65EE16ACC360FA4D99C96DC085B3F7721F43AA@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hoc08nk7t.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F443D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hlivcnhe2.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F45A8@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5haabsnfg2.wl%tiwai@suse.de>
	<20110802154815.GE25884@opensource.wolfsonmicro.com>
	<s5hipqfn65k.wl%tiwai@suse.de>
	<20110802164005.GI25884@opensource.wolfsonmicro.com>
	<s5h4o1zsn6o.wl%tiwai@suse.de>
Message-ID: <20110803052333.GA16141@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2011 at 08:06:23PM +0200, Takashi Iwai wrote:

> example.  So, alternatively, we can put the condition in some generic
> filter function like readable/writeble things.

Yes, I suggested that already, these are just unreadable and unwritable
registers :/
