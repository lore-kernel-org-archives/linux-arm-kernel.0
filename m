From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 14 Oct 2013 15:44:44 -0700
Subject: [GIT PULL 3/6] omap hwmod changes for v3.13 merge window
In-Reply-To: <5258a9a6.4a17e00a.5fb3.ffff9bf3SMTPIN_ADDED_MISSING@mx.google.com>
 (Tony Lindgren's message of "Fri, 11 Oct 2013 18:44:58 -0700")
References: <5258a9a6.4a17e00a.5fb3.ffff9bf3SMTPIN_ADDED_MISSING@mx.google.com>
Message-ID: <87a9ib4gmb.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:
>
>   Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/hwmod-signed
>
> for you to fetch changes up to 254f57a92987b6cde6004f58d6b847813dfb9e0e:
>
>   ARM: OMAP5: hwmod: add missing ocp2scp hwmod data (2013-10-11 15:37:05 -0700)
>
> ----------------------------------------------------------------
> omap hwmod related changes via Paul Walmsley <paul@pwsan.com>:
>
> Some OMAP hwmod changes for 3.13.  Significant changes here include:
>
> - support for moving some of the hwmod flags to DT data
>
> - support for the SSI, hardware spinlock, USB host/TLL, and RNG IP
>   blocks for various OMAPs
>
> - a fix that again decouples hwmod data changes from unrelated DT data
>   patchsets
>
> Basic test logs are available at:
>
> http://www.pwsan.com/omap/testlogs/prcm_fixes_v3.13/20131009094936/
>
> ----------------------------------------------------------------

Pulled into next/soc,

Thanks,

Kevin
