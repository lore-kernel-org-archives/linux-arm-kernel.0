From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 8 Jun 2010 00:52:16 +0100
Subject: [alsa-devel] [RFC PATCH v3 0/3] ep93xx i2s audio
In-Reply-To: <4C0D58BB.5030505@bluewatersys.com>
	(sfid-20100607_213827_729716_0AEBDFD1)
References: <1275628285-12642-1-git-send-email-ryan@bluewatersys.com>
	<1275914732.3045.105.camel@odin>
	<4C0D58BB.5030505@bluewatersys.com>
	(sfid-20100607_213827_729716_0AEBDFD1)
Message-ID: <F302D76F-8D7D-4F4B-ACC5-D7F76998AA4A@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 Jun 2010, at 21:38, Ryan Mallon wrote:

> Russell, Mark has picked up patch 2/3 via the alsa tree. Should I submit
> 1/3 and 3/3 via the arm patch system with Liam's ack?

At least 3/3 needs to go via the ASoC tree since it depends on 2/3. It may make sense for all of them to go that way, or perhaps 1/3 could go separately via the ARM tree (in which case I'd ack it too).
