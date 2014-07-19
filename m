From: olof@lixom.net (Olof Johansson)
Date: Sat, 19 Jul 2014 14:31:21 -0700
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.17 (round 2)
In-Reply-To: <20140718221351.GN24496@titan.lakedaemon.net>
References: <20140718221351.GN24496@titan.lakedaemon.net>
Message-ID: <20140719213121.GB15676@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 06:13:51PM -0400, Jason Cooper wrote:
> All,
> 
> Here's all the defconfig changes we have for mvebu this time around.
> The big one is the removal of kirkwood_defconfig, cooresponding to the
> mach-kirkwood/ removal in mvebu/soc.
> 
> This is an incremental pull request from tags/mvebu-defconfig-3.17 up to
> tags/mvebu-defconfig-3.17-2 on the mvebu/defconfig branch.
> 
> Please pull.
> 
> thx,
> 
> Jason.
> 
> The following changes since commit 5658d58545388850c77a070fb3b882ddd958eb88:
> 
>   ARM: multi_v5: Enable LaCie 2Big and 5Big Network v2 (2014-06-20 20:50:23 +0000)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-3.17-2
> 
> for you to fetch changes up to c1eed8d2ff67b18f3892016f40ad6899ac6cf477:
> 
>   ARM: mvebu: update mvebu_v7_defconfig with cpufreq support (2014-07-16 12:51:39 +0000)
> 
> ----------------------------------------------------------------
> mvebu defconfig changes for v3.17 (round 2)
> 
>  - mvebu
>    - Add appended_dtb support
>    - Add devtmpfs support
>    - Add 375 network driver
>    - Add cpuidle support
>    - Add cpufreq support
> 
>  - kirkwood
>    - Remove kirkwood_defconfig

Merged, thanks.

-Olof
