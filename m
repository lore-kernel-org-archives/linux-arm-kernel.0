From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 11 Apr 2012 16:56:05 -0600 (MDT)
Subject: [PATCH 09/12] arm: omap3: am35x: Add SDRC EMIF4 feature
In-Reply-To: <1334171147-7517-10-git-send-email-mgreer@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-10-git-send-email-mgreer@animalcreek.com>
Message-ID: <alpine.DEB.2.00.1204111655440.29473@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Apr 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> The typical SDRAM Controller Subsystem module (SDRC)
> on TI OMAP3 devices has two submodules: the SDRAM Memory
> Scheduler (SMS) submodule, and the SDRC submodule--the
> 'SDRC' acronym/term is overloaded.  The am35x family of
> devices is different in that it has an EMIF4 submodule
> instead of an SDRC submodule.  The SMS submodules are
> similar, though.

By the way, thanks for the great patch descriptions; they are very 
helpful.


- Paul
