From: olof@lixom.net (Olof Johansson)
Date: Thu, 31 Dec 2015 14:20:08 +0100
Subject: [PATCH RFC] ARM: tango4: Fix build issues
In-Reply-To: <5682F1AE.60108@free.fr>
References: <567DBA04.4060709@free.fr>
 <5682F1AE.60108@free.fr>
Message-ID: <20151231132008.GA1547@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 29, 2015 at 09:48:47PM +0100, Mason wrote:
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

In general, even if our branch is not yet in Linus' tree, we prefer to not
rebuild and rewind/rebase our branches. So yes, in this case it should be
an incremental patch like this is.


-Olof
