From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 21:06:28 -0800
Subject: [GIT PULL 1/5] i.MX non-critical DT fixes for 4.11
In-Reply-To: <1485662803-31235-1-git-send-email-shawnguo@kernel.org>
References: <1485662803-31235-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20170130050628.GP18943@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 12:06:39PM +0800, Shawn Guo wrote:
> The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:
> 
>   Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-nc-4.11
> 
> for you to fetch changes up to 8b649e426336d7d4800ff9c82858328f4215ba01:
> 
>   ARM: dts: imx53-qsb-common: fix FEC pinmux config (2017-01-29 10:05:33 +0800)
> 
> ----------------------------------------------------------------
> i.MX non-critical device tree fixes for 4.11:
>  - A couple of fixes on anatop regulator voltage and constraints
>    according to hardware datasheet.
>  - Correct FEC interrupt routing for i.MX6QP which has got the hardware
>    bug found on i.MX6Q fixed.
>  - Remove unit address from i.MX6 LDB device node to fix DTC warning.
>  - A fix on imx53-qsb board FEC pinmux config to remove the dependency
>    on firmware for setting up pins.
>  - A series from Sascha to fix LPSR pins for i.MX7 boards.

Thanks, merged into next/dt (we normally carry non-critical fixes separately
but these seemed to go better on the dt topic branch).


-Olof
