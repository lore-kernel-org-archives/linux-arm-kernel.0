From: mgreer@animalcreek.com (Mark A. Greer)
Date: Wed, 11 Apr 2012 16:23:43 -0700
Subject: [PATCH 09/12] arm: omap3: am35x: Add SDRC EMIF4 feature
In-Reply-To: <alpine.DEB.2.00.1204111655440.29473@utopia.booyaka.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-10-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1204111655440.29473@utopia.booyaka.com>
Message-ID: <20120411232343.GJ31197@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 04:56:05PM -0600, Paul Walmsley wrote:
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
> By the way, thanks for the great patch descriptions; they are very 
> helpful.

I should have left them short.  Maybe I'd have less homework to do then! ;)
