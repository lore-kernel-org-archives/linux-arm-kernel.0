From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 6 Jul 2015 17:14:06 +0800
Subject: [RFC PATCH 1/3] arm: psci: rename psci_smp.c to psci.c
In-Reply-To: <559A450E.50801@linaro.org>
References: <1436014910-1201-1-git-send-email-jszhang@marvell.com>
 <1436014910-1201-2-git-send-email-jszhang@marvell.com>
 <559A450E.50801@linaro.org>
Message-ID: <20150706171406.2e236f8c@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Jul 2015 11:06:22 +0200
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> On 07/04/2015 03:01 PM, Jisheng Zhang wrote:
> > This will prepare for next commit to enable PSCI for UP systems so that
> > calls like cpu_suspend can be made functional on UP too.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >   arch/arm/kernel/Makefile   |   2 +-
> >   arch/arm/kernel/psci.c     | 130 +++++++++++++++++++++++++++++++++++++++++++++
> >   arch/arm/kernel/psci_smp.c | 130 ---------------------------------------------
> >   3 files changed, 131 insertions(+), 131 deletions(-)
> >   create mode 100644 arch/arm/kernel/psci.c
> >   delete mode 100644 arch/arm/kernel/psci_smp.c
> 
> When you move or rename a file, use the -M option with git when sending 
> the email. Instead of providing a big diff file, it will just annotate 
> the renaming.

Thanks for the kindly remind and tips, I didn't know this before. Will take
care that in the future.

Thanks a lot,
Jisheng
