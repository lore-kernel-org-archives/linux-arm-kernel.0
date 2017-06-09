From: robh@kernel.org (Rob Herring)
Date: Fri, 9 Jun 2017 11:29:41 -0500
Subject: [RFC PATCH 3/4] ARM: l2x0: add arm, ecc-enable property for aurora
In-Reply-To: <20170608041124.4624-4-chris.packham@alliedtelesis.co.nz>
References: <20170608041124.4624-1-chris.packham@alliedtelesis.co.nz>
 <20170608041124.4624-4-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170609162941.hlrkfqm7jfxtzzuu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 04:11:23PM +1200, Chris Packham wrote:
> The aurora cache on the Marvell Armada-XP SoC supports ECC protection
> for the L2 data arrays. Add a "arm,ecc-enable" device tree property
> which can be used to enable this.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  Documentation/devicetree/bindings/arm/l2c2x0.txt | 2 ++
>  arch/arm/mm/cache-l2x0.c                         | 7 +++++++
>  2 files changed, 9 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
