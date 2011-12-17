From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 17 Dec 2011 11:41:47 -0500 (EST)
Subject: [PATCH 23/23] ARM: move VMALLOC_END down temporarily for shmobile
In-Reply-To: <CANqRtoQZqZykFCFU9t_Oh55oXEUZhe8O6VPvwdJG2i6Yhr_EDg@mail.gmail.com>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
 <1321422521-1138-24-git-send-email-nico@fluxnic.net>
 <CANqRtoQZqZykFCFU9t_Oh55oXEUZhe8O6VPvwdJG2i6Yhr_EDg@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1112171139390.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Dec 2011, Magnus Damm wrote:

> On Wed, Nov 16, 2011 at 2:48 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > From: Nicolas Pitre <nicolas.pitre@linaro.org>
> >
> > THIS IS A TEMPORARY HACK. ?The purpose of this is _only_ to avoid a
> > regression on an existing machine while a better fix is implemented.
> >
> > On shmobile the consistent DMA memory area was set to 158MB in commit
> > 28f0721a79 with no explanation. ?The documented size for this area should
> > vary between 2MB and 14MB, and none of the other ARM targets exceed that.
> >
> > The included #warning is therefore meant to be noisy on purpose to get
> > shmobile maintainers attention and this commit reverted once this
> > consistent DMA size conflict is resolved.
> >
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Cc: Magnus Damm <damm@opensource.se>
> > Cc: Paul Mundt <lethal@linux-sh.org>
> > ---
> 
> Hi Nicolas,
> 
> Thanks for your work on this! Please excuse the slow progress. I have
> now gotten around to remove the special mach-shmobile behavior.
> 
> The change is included in the unfortunately mangled patch below. Where
> would you like me to submit the patch?

Just send it to me non mangled and I'll take care of it.

Thanks!


Nicolas
