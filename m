From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 25 Nov 2009 15:43:10 +0000
Subject: [PATCH 2/3] ASoC: add phycore-ac97 sound support
In-Reply-To: <1259163666-30344-3-git-send-email-s.hauer@pengutronix.de>
References: <1259163666-30344-1-git-send-email-s.hauer@pengutronix.de>
	<1259163666-30344-2-git-send-email-s.hauer@pengutronix.de>
	<1259163666-30344-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20091125154309.GB12750@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 04:41:05PM +0100, Sascha Hauer wrote:

> +#include "../codecs/mc13783.h"

Bitrot (and won't build right now as a result).  Otherwise this looks OK
to me.
