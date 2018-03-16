From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 16 Mar 2018 08:55:16 +0800
Subject: [GIT PULL 2/6] i.MX SoC changes for 4.17
In-Reply-To: <CAK8P3a1vNZf9uk+u+mnot37TuKYfN-P_xxXm+uG6p0oyPjZTEw@mail.gmail.com>
References: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
 <1521113800-16401-2-git-send-email-shawnguo@kernel.org>
 <CAK8P3a1vNZf9uk+u+mnot37TuKYfN-P_xxXm+uG6p0oyPjZTEw@mail.gmail.com>
Message-ID: <20180316005515.GO26859@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 04:12:33PM +0100, Arnd Bergmann wrote:
> On Thu, Mar 15, 2018 at 12:36 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> > The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
> >
> >   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.17
> >
> > for you to fetch changes up to dee5dee2a5b285d20f55a4758d3a51349691eeea:
> >
> >   ARM: imx: Add basic msl support for imx6sll (2018-03-09 09:22:06 +0800)
> >
> > ----------------------------------------------------------------
> > i.MX SoC changes for 4.17:
> >  - Add i.MX 6SoloLiteLite (i.MX6SLL) SoC support on top of the existing
> >    i.MX6SL platform code.
> >  - Improve the SoC revision mapping by utilizing the MAJOR field of
> >    ANATOP DIGPROG register.
> >  - Add CPUIDLE_FLAG_TIMER_STOP flag for cpuidle ARM power off state,
> >    so that we can use ARM generic timer for some i.MX6 SoC.
> >  - Set low-power interrupt mask for i.MX25 to support STOP mode.
> >  - Drop EPIT driver as there is no user of it.
> >  - Simplify the error path of imx6_pm_get_base() a bit.
> 
> Pulled into next/soc. However, I need two fixups for bugs I ran into during
> linux-next randconfig testing. Sending them out now, please Ack so
> I can apply them directly.

Thanks for the fixups.  I have just Ack-ed them.

Shawn
