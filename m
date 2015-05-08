From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 8 May 2015 09:14:26 +0530
Subject: [PATCH 4/6] dmaengine: sun6i: Add support for Allwinner H3
 (sun8i) variant
In-Reply-To: <20150506101342.GC11057@lukather>
References: <1430904693-1404-1-git-send-email-jenskuske@gmail.com>
 <1430904693-1404-5-git-send-email-jenskuske@gmail.com>
 <20150506101342.GC11057@lukather>
Message-ID: <20150508034426.GX3521@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 12:13:42PM +0200, Maxime Ripard wrote:
> On Wed, May 06, 2015 at 11:31:31AM +0200, Jens Kuske wrote:
> > The H3 SoC has the same dma engine as the A31 (sun6i), with a
> > reduced amount of endpoints and physical channels. Add the proper
> > config data and compatible string to support it.
> > 
> > Signed-off-by: Jens Kuske <jenskuske@gmail.com>

This looks fine to me, I think can be merged now. Do you guys want the
mainatainers to pick up patches to their subsystem or merge them tgether,
though don't see any dependency though

-- 
~Vinod
