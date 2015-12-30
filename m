From: stillcompiling@gmail.com (Joshua Clayton)
Date: Tue, 29 Dec 2015 18:10:59 -0800
Subject: [PATCH RFC] ARM: tango4: Fix build issues
In-Reply-To: <5682F1AE.60108@free.fr>
References: <567DBA04.4060709@free.fr> <5682F1AE.60108@free.fr>
Message-ID: <1525426.F8aV4pV4EX@diplodocus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,
On Tuesday, December 29, 2015 09:48:47 PM Mason wrote:
> On 25/12/2015 22:49, Mason wrote:
> 
> > Move SMP setup to platsmp.c
> > Specify the CPU type to the assembler, and only for smc.S
> > 
> > Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> > ---
> >  arch/arm/mach-tango/Makefile  |  3 ++-
> >  arch/arm/mach-tango/platsmp.c | 16 ++++++++++++++++
> >  arch/arm/mach-tango/setup.c   | 14 --------------
> >  3 files changed, 18 insertions(+), 15 deletions(-)
> >  create mode 100644 arch/arm/mach-tango/platsmp.c
> 
> I have a question. When the original commit hasn't been pushed to
> Linus' tree yet, is the original commit simply amended?
> (fixup option in rebase -i)
> 
> Or are they handled as regular commits on top of the previous commits?
> 

 Unless you are asked to revise and resubmit a patch, so that the 
original is never accepted, all follow on patches end up a separate commits.

> Regards.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kerne

Merry Christmas & Happy New Year,

Joshua
