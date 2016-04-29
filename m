From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 29 Apr 2016 12:02:59 -0700
Subject: [GIT PULL] DaVinci fixes for v4.6
In-Reply-To: <5723286E.7050601@ti.com> (Sekhar Nori's message of "Fri, 29 Apr
 2016 14:55:02 +0530")
References: <5723286E.7050601@ti.com>
Message-ID: <m2inz0i6fw.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar Nori <nsekhar@ti.com> writes:

> Sorry for sending this late, but I was waiting to see if
> Greg would rather send this (because the issue came
> through patches he merged). I have not received a response
> and there is danger of missing v4.6 altogether if we wait
> any further.
>
> So here it is. Its based on latest in Linus's tree.
>
> Regards,
> Sekhar
>
> The following changes since commit 92c19ea9535707701861b7533253a516c7d115c9:
>
>   Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2016-04-28 20:24:27 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.6
>
> for you to fetch changes up to 29b933b6d84219af8456dee172ddc6d676ebbcd3:
>
>   ARM: davinci: only use NVMEM when available (2016-04-29 14:21:14 +0530)
>
> ----------------------------------------------------------------
> This patch fixes build breakage when
> nvmem framework is built as module.
>
> ----------------------------------------------------------------

Our fixes branch was based on -rc5 and yours was on -rc6, so rather than
pulling in all of -rc6, I just cherry-picked this one patch.

Anyways, pushed to arm-soc/fixes.

Thanks,

Kevin
