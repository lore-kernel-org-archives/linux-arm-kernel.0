From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 23 Aug 2013 12:17:06 -0700
Subject: [GIT PULL 4/5] ARM: mxs: soc changes for 3.12
In-Reply-To: <1376833688-24542-4-git-send-email-shawn.guo@linaro.org> (Shawn
 Guo's message of "Sun, 18 Aug 2013 21:48:07 +0800")
References: <1376833688-24542-1-git-send-email-shawn.guo@linaro.org>
 <1376833688-24542-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <87siy0kyj1.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo <shawn.guo@linaro.org> writes:

> The following changes since commit 5ae90d8e467e625e447000cb4335c4db973b1095:
>
>   Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-soc-3.12
>
> for you to fetch changes up to 7543360721cfdce687c4b53a03f08f5ba21d4745:
>
>   ARM: mxs: pm: Include "pm.h" (2013-08-18 16:34:57 +0800)
>
> ----------------------------------------------------------------
> It contains mxs soc changes for 3.12.
>
> - Run savedefconfig on mxs_defconfig to clean it up
> - Fix on mxs_restart() routine for interrupt context calling
> - A few other random updates and cleanups

Pulled into next/soc

Kevin
