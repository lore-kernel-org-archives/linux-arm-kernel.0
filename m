From: Igal.Liberman@freescale.com (Liberman Igal)
Date: Thu, 30 Jul 2015 15:32:32 +0000
Subject: [RFC PATCH 8/8] powerpc/fsl: Use new clockgen binding
In-Reply-To: <1434682158-7243-9-git-send-email-scottwood@freescale.com>
References: <1434682158-7243-1-git-send-email-scottwood@freescale.com>
 <1434682158-7243-9-git-send-email-scottwood@freescale.com>
Message-ID: <DM2PR03MB50986F3471DF3DD74494002E68B0@DM2PR03MB509.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Regards,
Igal Liberman.

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Friday, June 19, 2015 5:49 AM
> To: Mike Turquette; Tang Yuantian-B29983
> Cc: Rafael J. Wysocki; Liberman Igal-B31950; Bucur Madalin-Cristian-B32716;
> linux-clk at vger.kernel.org; linux-pm at vger.kernel.org; linuxppc-
> dev at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; Wood Scott-B07421
> Subject: [RFC PATCH 8/8] powerpc/fsl: Use new clockgen binding
> 
> The driver retains compatibility with old device trees, but we don't want the
> old nodes lying around to be copied, or used as a reference (some of the
> mux options are incorrect), or even just being clutter.
> 
> We will also need the #clock-cells in the clockgen node in order to add fman
> nodes.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---

Tested on: several e500mc, e5500 and e6500 platforms.

Tested-by: Igal Liberman <Igal.Liberman@freescale.com>
