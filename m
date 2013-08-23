From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 23 Aug 2013 12:17:20 -0700
Subject: [GIT PULL 5/5] ARM: mxs: device tree changes for 3.12
In-Reply-To: <1376833688-24542-5-git-send-email-shawn.guo@linaro.org> (Shawn
 Guo's message of "Sun, 18 Aug 2013 21:48:08 +0800")
References: <1376833688-24542-1-git-send-email-shawn.guo@linaro.org>
 <1376833688-24542-5-git-send-email-shawn.guo@linaro.org>
Message-ID: <87ob8okyin.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo <shawn.guo@linaro.org> writes:

> The following changes since commit 5ae90d8e467e625e447000cb4335c4db973b1095:
>
>   Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-dt-3.12
>
> for you to fetch changes up to 23ad6f65748cd7fbaf03c1d36211bc1cbdf4ed45:
>
>   ARM: dts: mxs: add pin config for LCD sync and clock pins (2013-08-16 16:26:53 +0800)
>
> ----------------------------------------------------------------
> It contains mxs device tree changes for 3.12.
>
> - New board addition and hogpins cleanup for Crystalfontz
> - New pinctrl entry addition for lcd, ssp2 and saif0
> - Add alias and labels for various nodes
> - Enable devices like LRADC and USB for a couple of imx23 boards,
>   and backlight for M28EVK

Pulled into next/dt

Kevin
