From: olof@lixom.net (Olof Johansson)
Date: Sun, 14 Apr 2013 20:56:49 -0700
Subject: [GIT PULL] msm fixes for 3.10
In-Reply-To: <8yar4ifpdy7.fsf@huya.qualcomm.com>
References: <8ya7gk7qsnp.fsf@huya.qualcomm.com>
 <8yar4ifpdy7.fsf@huya.qualcomm.com>
Message-ID: <20130415035649.GD10949@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 03:43:44PM -0700, David Brown wrote:
> The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:
> 
>   Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git tags/msm-fix-3.10
> 
> for you to fetch changes up to 73a8c28f167c9e7bc42eafc0bcbd298031709430:
> 
>   ARM: msm: Fix uncompess.h tx underrun check (2013-04-11 09:40:35 -0700)
> 
> ----------------------------------------------------------------
> Some minor fixes for MSM for 3.10
> 
>   - Fix a timer problem that causes missed ticks and hangs.
> 
>   - Fix a problem with the decompressor UART dropping characters.
> 
> ----------------------------------------------------------------
> Stephen Boyd (2):
>       ARM: msm: Stop counting before reprogramming clockevent
>       ARM: msm: Fix uncompess.h tx underrun check
> 
>  arch/arm/mach-msm/include/mach/uncompress.h | 2 +-
>  arch/arm/mach-msm/timer.c                   | 5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)

Looks like the "Stop counting before reprogramming" patch has already been
merged through fixes for 3.9.

Since that was provided in a branch with the same SHA, there's no problem with
this branch and I've pulled it, but in the future it'd be nice to get a pull
request that doesn't list already merged patches since the diffstat won't match
when I compare them otherwise.



-Olof
