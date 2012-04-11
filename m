From: mgreer@animalcreek.com (Mark A. Greer)
Date: Wed, 11 Apr 2012 16:22:20 -0700
Subject: [PATCH 10/12] arm: omap3: am35x: Add minimal EMIF4 support
In-Reply-To: <alpine.DEB.2.00.1204111529120.29473@utopia.booyaka.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-11-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1204111529120.29473@utopia.booyaka.com>
Message-ID: <20120411232220.GI31197@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 03:31:25PM -0600, Paul Walmsley wrote:
> cc Aneesh
> 
> On Wed, 11 Apr 2012, Mark A. Greer wrote:
> 
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > 
> > The typical SDRAM Controller Subsystem module (SDRC)
> > on TI OMAP3 devices has two submodules: the SDRAM Memory
> > Scheduler (SMS) submodule, and the SDRC submodule--the
> > 'SDRC' acronym/term is overloaded.  The am35x family of
> > devices is different in that it has an EMIF4 submodule
> > instead of an SDRC submodule.  The SMS submodules are
> > similar, though.
> 
> The best thing to do is to add an EMIF driver stub that is initialized 
> based on hwmod data, rather than hacking this into the existing SDRC.
> 
> I don't know what the current state of the EMIF driver is.  Aneesh, 
> do you know what the current status is?
> 
> If it's not going upstream for some reason, then I'd suggest adding 
> arch/arm/mach-omap2/emif.c for now.

Okay, thanks Paul.

Mark
--
