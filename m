From: horms@verge.net.au (Simon Horman)
Date: Tue, 5 Jun 2018 09:49:38 +0200
Subject: [PATCH v3 8/8] ARM: dts: rcar-gen2: Remove unused VIN properties
In-Reply-To: <20180604122325.GH19674@bigcity.dyn.berto.se>
References: <1527606359-19261-1-git-send-email-jacopo+renesas@jmondi.org>
 <1527606359-19261-9-git-send-email-jacopo+renesas@jmondi.org>
 <20180604122325.GH19674@bigcity.dyn.berto.se>
Message-ID: <20180605074938.mljwmgpjlplvkp2v@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 04, 2018 at 02:23:25PM +0200, Niklas S?derlund wrote:
> Hi Jacopo,
> 
> Thanks for your work.
> 
> On 2018-05-29 17:05:59 +0200, Jacopo Mondi wrote:
> > The 'bus-width' and 'pclk-sample' properties are not parsed by the VIN
> > driver and only confuse users. Remove them in all Gen2 SoC that use
> > them.
> > 
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> 
> The more I think about this the more I lean towards that this patch 
> should be dropped. The properties accurately describes the hardware and 
> I think there is value in that. That the driver currently don't parse or 
> make use of them don't in my view reduce there value. Maybe you should 
> break out this patch to a separate series?

I also think there is value in describing the hardware not the state of the
driver at this time.  Is there any missmatch between these properties and
the bindings?
