From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Nov 2016 19:21:21 -0800
Subject: [GIT PULL] DaVinci fix for v4.9-rc
In-Reply-To: <f57fbfde-89ff-fdac-2a04-e8a4788b4ee5@ti.com>
References: <f57fbfde-89ff-fdac-2a04-e8a4788b4ee5@ti.com>
Message-ID: <20161108032121.GG2106@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 04:48:44PM +0530, Sekhar Nori wrote:
> The following changes since commit a909d3e636995ba7c349e2ca5dbb528154d4ac30:
> 
>   Linux 4.9-rc3 (2016-10-29 13:52:02 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.9
> 
> for you to fetch changes up to 36173c2d023bad4dbad6ed0e6e886fde10ec8f2f:
> 
>   ARM: davinci: da850: Fix pwm name matching (2016-11-01 15:30:03 +0530)
> 
> ----------------------------------------------------------------
> This patch enables usage of multiple eCAP and eHRPWM devices
> using PWM sysfs entries.
> 
> Without this patch, creation of multiple entries fails due
> to name clash.
> 
> This is not a v4.9 regression but it will be nice to fix it
> soon.

Hi,

Merged into next/fixes-non-critical -- we're getting some pushback on fixes
for this cycle, so I'm being a bit more conservative.


-Olof
