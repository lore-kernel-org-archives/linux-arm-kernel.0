From: olof@lixom.net (Olof Johansson)
Date: Thu, 1 Jun 2017 16:52:06 -0700
Subject: [pull request][v3] soc/fsl/qbman: Enable QBMan on ARM Platforms
In-Reply-To: <AM5PR0402MB2691C73822FA33F05AF9C678ECFC0@AM5PR0402MB2691.eurprd04.prod.outlook.com>
References: <1495462842-14402-1-git-send-email-madalin.bucur@nxp.com>
 <AM5PR0402MB2691C73822FA33F05AF9C678ECFC0@AM5PR0402MB2691.eurprd04.prod.outlook.com>
Message-ID: <20170601235206.GA13314@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 26, 2017 at 12:31:15PM +0000, Madalin-Cristian Bucur wrote:
> Adding linux-arm-kernel at lists.infradead.org
> 
> > -----Original Message-----
> > From: Madalin Bucur [mailto:madalin.bucur at nxp.com]
> > Sent: Monday, May 22, 2017 5:21 PM
> > To: arm at kernel.org
> > Cc: Roy Pledge <roy.pledge@nxp.com>; oss at buserror.net;
> > catalin.marinas at arm.com; Madalin-Cristian Bucur <madalin.bucur@nxp.com>
> > Subject: [pull request][v3] soc/fsl/qbman: Enable QBMan on ARM Platforms
> > 
> > Hi,
> > 
> > This patch series enables DPAA1 QBMan devices for ARM and
> > ARM64 architectures. This allows the LS1043A and LS1046A to use
> > QBMan functionality.
> > 
> > Changes since v2:
> > Fixed some misspellings
> > Added 'no-map' constraint to device tree bindings
> > Described ordering contraint on regions in the device tree
> > Removed confusing comment regarding non-shareable mappings
> > Added warning if old reserved-memory technique is used on ARM
> > 
> > Changes since v1:
> > Reworked private memory allocations to use shared-dma-pool on ARM
> > platforms
> > 
> > Thanks,
> > Madalin

So, here's a pull request for something called 'qbman' that obviously
is related to Freescale SoCs, but there's no motivation at all as to why
it's needed, what it does, and why we would be interested in merging it. DPAA1
is also completely unexplained. A few words to give someone an idea what this
is would be a good idea.

Also, we normally ask that these pull requests come in through the
maintainer maintainer, which for Freescale platform drivers is Scott
Wood, or if preferred it can also come in through the overall Freescale
ARM maintainers (Shawn Guo, Fabio Estavam or Sascha Hauer).


Thanks,

-Olof
