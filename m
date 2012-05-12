From: olof@lixom.net (Olof Johansson)
Date: Fri, 11 May 2012 23:55:14 -0700
Subject: [GIT PULL] Adopt pinctrl support for imx and mxs drivers
In-Reply-To: <20120512021726.GC17875@S2101-09.ap.freescale.net>
References: <20120512021726.GC17875@S2101-09.ap.freescale.net>
Message-ID: <CAOesGMjpRJO5+UsNoo09pAZJo-_WG=Gcf8t8qwboH+-PoOw2-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Fri, May 11, 2012 at 7:17 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Hi Arnd, Olof,
>
> This series adds dummy pinctrl states for imx and mxs platforms and
> then adopts pinctrl support for some outstanding imx and mxs drivers.
> The reason that the series mixes two sub-architectures patches is some
> drivers are shared between two sub-architectures, so we need to handle
> them as a whole.
>
> I haven't got the acks from all subsystem maintainers. Considering
> we are close to merge window now, and the change is quite simple while
> mxs device tree series depends on it, I would like to send the pull
> request right away and hopefully to get it expose on linux-next soon.
> I copied subsystem maintainers here in case they see problem to have
> their patches go through arm-soc.
>
> It depends on pinctrl branch below.
>
> ?git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel (or for-next)
>
> Per Linus, his devel branch is identify to for-next, and both branches
> are stable (non-rebased).

The driver changes looks reasonably contained, so I pulled this branch
in. If we get a hard NACK from someone we can drop it if we have to
(but hopefully that won't happen).

Please double-check that my conflict resolution in for-next was done right.


-Olof
