From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 16 Aug 2017 11:44:59 +0200
Subject: [PATCH 3/5] reset: Add Realtek RTD1295 driver
In-Reply-To: <20170816003847.6208-4-afaerber@suse.de>
References: <20170816003847.6208-1-afaerber@suse.de>
 <20170816003847.6208-4-afaerber@suse.de>
Message-ID: <1502876699.7596.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On Wed, 2017-08-16 at 02:38 +0200, Andreas F?rber wrote:
> Add a per-register reset controller driver. This deals with the fact
> that not all registers are adjoined.

the way you handle the non-contiguous reset registers, this looks like
a candidate to join?the recently discussed reset-simple driver [1].
Could you check if that would fit?

regards
Philipp
