From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Mar 2014 11:21:18 +0000
Subject: [PATCH RFC v2 0/6] drm/i2c: Move tda998x to a couple
 encoder/connector
In-Reply-To: <cover.1395397665.git.moinejf@free.fr>
References: <cover.1395397665.git.moinejf@free.fr>
Message-ID: <20140321112118.GH7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 11:27:45AM +0100, Jean-Francois Moine wrote:
> The 'slave encoder' structure of the tda998x driver asks for glue
> between the DRM driver and the encoder/connector structures.

Given how close we are to the coming merge window, that the discussion
about the of-graph bindings is still going on without concensus being
reached, and that this driver is not in staging, this needs to be
delayed until the following merge window when hopefully we have a
clearer picture about the DT side of this.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
