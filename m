From: olof@lixom.net (Olof Johansson)
Date: Sat, 26 May 2018 12:10:42 -0700
Subject: [GIT PULL v2] arm64: hisilicon fixes for 4.17
In-Reply-To: <5B09A971.6030506@hisilicon.com>
References: <5B09A971.6030506@hisilicon.com>
Message-ID: <20180526191042.y4havyp62ngxa64c@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 26, 2018 at 07:37:37PM +0100, Wei Xu wrote:
> Hi Olof, Hi Arnd,
> 
> Please help to pull the following fix.
> Sorry for the late fix pull since we just got the patch.
> And if the pull is too late, I will rebase the patch after 4.18-rc1 released.
> Thanks!
> 
> Best Regards,
> Wei
> 
> ---
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/hisi-fixes-for-4.17v2
> 
> for you to fetch changes up to 9c6d26df1fae6ad4718d51c48e6517913304ed27:
> 
>   arm64: dts: hikey: Fix eMMC corruption regression (2018-05-26 17:51:47 +0100)
> 
> ----------------------------------------------------------------
> ARM64: hisi fixes for 4.17
> 
> - Remove eMMC max-frequency property to fix eMMC corruption on hikey board
> 
> ----------------------------------------------------------------
> John Stultz (1):
>       arm64: dts: hikey: Fix eMMC corruption regression

Merged, thanks.


-Olof
