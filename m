From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 8 Mar 2012 20:26:11 +0100 (CET)
Subject: Regression in 3.2.9 for omap-serial (at least)
In-Reply-To: <CAGGh5h3-1XhMO1-jiBdUJYgh4unRcPonvp=zcXLKMJBfS+qpuQ@mail.gmail.com>
References: <lyk42vxsz2.fsf@ensc-virt.intern.sigma-chemnitz.de>
 <alpine.LFD.2.02.1203081246130.2742@ionos>
 <CAGGh5h3-1XhMO1-jiBdUJYgh4unRcPonvp=zcXLKMJBfS+qpuQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1203082024450.2742@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Mar 2012, jean-philippe francois wrote:

> Le 8 mars 2012 12:46, Thomas Gleixner <tglx@linutronix.de> a ?crit :
> > On Thu, 8 Mar 2012, Enrico Scholz wrote:
> >> Hi,
> >>
> >> the commit "genirq: Unmask oneshot irqs when thread was not woken"[1]
> >> breaks at least the omap-serial driver which requests a shared interrupt
> >
> > Fixed with 52abb700e16a9a
> 
> How can I find it ?
> I tried searching in various tree on git.kernel.org,
> but could not find the fix.

It's in Linus tree.

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=52abb700e16a9aa4cbc03f3d7f80206cbbc80680
