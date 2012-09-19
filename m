From: bhutchings@solarflare.com (Ben Hutchings)
Date: Wed, 19 Sep 2012 16:14:02 +0100
Subject: [PATCH v2 7/9] net/macb: ethtool interface: add register dump
 feature
In-Reply-To: <20ebfb29f6f4a84d8ba20553e2d81cd456f438de.1348055112.git.nicolas.ferre@atmel.com>
References: <cover.1348055112.git.nicolas.ferre@atmel.com>
 <20ebfb29f6f4a84d8ba20553e2d81cd456f438de.1348055112.git.nicolas.ferre@atmel.com>
Message-ID: <1348067642.4836.58.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-09-19 at 13:55 +0200, Nicolas Ferre wrote:
> Add macb_get_regs() ethtool function and its helper function:
> macb_get_regs_len().
> The version field is deduced from the IP revision which gives the
> "MACB or GEM" information. An additional version field is reserved.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Reviewed-by: Ben Hutchings <bhutchings@solarflare.com>
[...]

Please also send the register dump decoder for the ethtool utility once
this series is accepted.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
