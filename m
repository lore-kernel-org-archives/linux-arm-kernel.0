From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 17 Oct 2013 14:39:01 -0700
Subject: [GIT PULL] DaVinci: an SoC update for v3.13
In-Reply-To: <525E068B.4020304@ti.com> (Sekhar Nori's message of "Wed, 16 Oct
 2013 08:52:51 +0530")
References: <525E068B.4020304@ti.com>
Message-ID: <87r4bj1ssq.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar Nori <nsekhar@ti.com> writes:

> The following changes since commit 61e6cfa80de5760bbe406f4e815b7739205754d2:
>
>   Linux 3.12-rc5 (2013-10-13 15:41:28 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.13/soc-2
>
> for you to fetch changes up to 859236d017978bb95f3e2794aece57da3a40fe5c:
>
>   ARM: davinci: convert to clockevents_config_and_register (2013-10-16 06:14:55 +0530)
>
> ----------------------------------------------------------------
> This pull request includes a patch to
> use clockevents_config_and_register()
> for registering the clockevent.
>
> ----------------------------------------------------------------

Pulled into next/soc.

In the future, please base these off of older -rc releases unless
there's a dependency.  That helps us from having to pull in the latest
-rc into several of our sub branches.  

In this case, since it looks like your branch isn't already in -next,
I've just rebased it onto -rc3 since that's where next/soc was currently
based.

Thanks,

Kevin
