From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 May 2014 09:35:57 +0100
Subject: [PATCH 2/2] ARM: Kconfig: remove dependence of
 CONFIG_DEBUG_RODATA on !kexec
In-Reply-To: <CAGXu5jK_RwA+3H9fSz4u9+hnFVuP5ST9x_sn1hSeNp98SK4TNg@mail.gmail.com>
References: <1399887117-2605-1-git-send-email-Nikolay.Borisov@arm.com>
 <1399887117-2605-2-git-send-email-Nikolay.Borisov@arm.com>
 <20140516164917.GE1694@arm.com>
 <CAGXu5jK_RwA+3H9fSz4u9+hnFVuP5ST9x_sn1hSeNp98SK4TNg@mail.gmail.com>
Message-ID: <20140520083557.GA21866@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 08:33:51PM +0100, Kees Cook wrote:
> On Fri, May 16, 2014 at 9:49 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, May 12, 2014 at 10:31:57AM +0100, Nikolay Borisov wrote:
> >> Remove DEBUG_RODATA dependence on !kexec since "ARM: kexec: Make .text R/W in
> >> machine_kexec" fixes the incompatibility between those 2
> >> options.
> >>
> >> Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
> >
> >   Acked-by: Will Deacon <will.deacon@arm.com>
> 
> We've got, from what I can see, about 4 sets of patches that are or
> revolve around DEBUG_RODATA. What do you think is the best way to
> gather everything together? Do you want me to build 1 giant set of
> patches that includes kexec, DEBUG_RODATA, FIXMAP, and kgdb all
> together, or should we just start flushing each one separately into
> the patch tracker?

It's probably worth you collating the patches together into a single series,
giving it some testing, then reposting that to the list. Then, assuming
nothing explodes, sending a pull request to rmk (although it's getting quite
late in the day for 3.16).

Sound like a plan?

Will
