From: davem@davemloft.net (David Miller)
Date: Mon, 11 Dec 2017 11:19:17 -0500 (EST)
Subject: [PATCH net v3] net: phy: meson-gxl: detect LPA corruption
In-Reply-To: <20171208110811.30789-1-jbrunet@baylibre.com>
References: <20171208110811.30789-1-jbrunet@baylibre.com>
Message-ID: <20171211.111917.1950680033944722044.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri,  8 Dec 2017 12:08:11 +0100

> I suppose this patch probably seems a bit hacky, especially the part
> about the link partner acknowledge. I'm trying to figure out if the
> value in MII_LPA makes sense but I don't have such a deep knowledge
> of the ethernet spec.

Yeah it's not the prettiest thing in the world, but if this is what you
need to check to detect this situation then there isn't much else you
can do.

Applied, thanks.
