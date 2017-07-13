From: horms@verge.net.au (Simon Horman)
Date: Thu, 13 Jul 2017 10:08:55 +0200
Subject: [PATCH 0/3] ARM: dts: r8a779[014]: Use R-Car Gen 2 fallback
 binding for vin nodes
In-Reply-To: <20170713050744.GA23854@bigcity.dyn.berto.se>
References: <1499777809-27492-1-git-send-email-horms+renesas@verge.net.au>
 <20170713050744.GA23854@bigcity.dyn.berto.se>
Message-ID: <20170713080855.GK5580@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 07:07:44AM +0200, Niklas S?derlund wrote:
> Hi Simon,
> 
> Thanks for your work.
> 
> On 2017-07-11 14:56:46 +0200, Simon Horman wrote:
> > Use R-Car Gen 2 fallback binding for vind nodes in DT for r8a779[014] SoCs.
> > 
> > This has no run-time effect for the current driver as the initialisation
> > sequence is the same for the SoC-specific binding for r8a779[014] and the
> > fallback binding for R-Car Gen 2
> > 
> > This is consistent with existing compat string usage in vin nodes for the
> > r8a779[23] SoCs.
> 
> For whole serries:
> 
> Acked-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

Thanks, applied for v4.14.
