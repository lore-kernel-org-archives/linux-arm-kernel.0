From: mgreer@animalcreek.com (Mark A. Greer)
Date: Fri, 27 Apr 2012 14:14:40 -0700
Subject: [PATCH v2] arm: omap3: am35x: Fix clockdomain dependencies
In-Reply-To: <alpine.DEB.2.00.1204261656160.10308@utopia.booyaka.com>
References: <1334866606-8291-1-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1204261656160.10308@utopia.booyaka.com>
Message-ID: <20120427211440.GB19196@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 04:56:39PM -0600, Paul Walmsley wrote:
> On Thu, 19 Apr 2012, Mark A. Greer wrote:
> 
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > 
> > The am35x family of SoCs do not have an IVA so
> > a parallel set of clockdomain dependencies are
> > required that are simililar to OMAP3 but without
> > any IVA dependencies.
> > 
> > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> 
> Thanks, queued for 3.5.

Thanks Paul.

FYI, I have a version rebased on top of Kevin's recent patch series
that renames OMAP3517 to AM35XX (among other things),
     "ARM: OMAP: remove IP checks from SoC family detection".

Would you like that one instead?

Mark
--
