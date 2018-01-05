From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Jan 2018 22:39:38 -0800
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.16
In-Reply-To: <cover.1513935930.git.horms+renesas@verge.net.au>
References: <cover.1513935930.git.horms+renesas@verge.net.au>
Message-ID: <20180105063938.yja5zzluekz4bgjd@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 11:29:33AM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC defconfig updates for v4.16.
> 
> 
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
> 
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v4.16
> 
> for you to fetch changes up to 1943cbd3b39ee3310494d5b531a906e836bb9f7f:
> 
>   ARM: shmobile: defconfig: Enable PWM (2017-12-20 09:29:49 +0100)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Defconfig Updates for v4.16
> 
> shmobile_defconfig:
> * Enable PWM timers, which are present on R-Car and RZ/G1 platforms,
>   as a built-in
> * Enable SGTL5000 audio codec, which is present on the he iWave RZ/G1M Q7
>   carrier board, as a built-in
> 
> multi_v7_defconfig:
> * Enable PWM timers, which are present on R-Car and RZ/G1 platforms,
>   as a module

Merged, thanks.


-Olof
