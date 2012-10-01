From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 1 Oct 2012 18:34:13 +0000 (UTC)
Subject: OMAP baseline test results for v3.6-rc7
In-Reply-To: <50645A1D.5040108@compulab.co.il>
References: <alpine.DEB.2.00.1209241919130.25811@utopia.booyaka.com>
 <50645A1D.5040108@compulab.co.il>
Message-ID: <alpine.DEB.2.00.1210011832420.2160@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Sep 2012, Igor Grinberg wrote:

> On 09/24/12 21:21, Paul Walmsley wrote:
> > 
> > * 3517EVM & CM-T3517: boot hangs               
> >   - Probably due to the use of NFS root; there are likely some Kconfig,
> >     board file, and PM issues with EMAC
> 
> Have you tried the nohlt boot parameter?
> It looks like the wfi is killing those SoCs once you use EMAC.

Haven't had the chance to do much debugging here yet.  M?ns and Mark Greer 
also suggested there may be a board file/Kconfig problem here that
should be checked.  Right now am just testing mainline.

- Paul
