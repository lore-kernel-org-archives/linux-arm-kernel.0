From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Apr 2015 13:26:10 -0700
Subject: [GIT PULL] qcom defconfig changes for 4.1-1
In-Reply-To: <alpine.DEB.2.02.1503271137360.17255@galak-ubuntu.qualcomm.com>
References: <alpine.DEB.2.02.1503271137360.17255@galak-ubuntu.qualcomm.com>
Message-ID: <20150403202610.GZ23023@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 11:38:49AM -0500, Kumar Gala wrote:
> The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
> 
>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-defconfig-for-4.1-1
> 
> for you to fetch changes up to dc344b62121c4e2ba5bd9d5bf7a2b4ce5f0487ce:
> 
>   ARM: qcom: Increase MMC_BLOCK_MINORS in defconfig (2015-03-25 16:16:59 -0500)
> 
> ----------------------------------------------------------------
> Qualcomm ARM Based defconfig Updates for v4.1-1
> 
> * Increase MMC_BLOCK_MINORS to 32 since qcom platforms have more than
>   16 partitions
> 
> ----------------------------------------------------------------
> Georgi Djakov (1):
>       ARM: qcom: Increase MMC_BLOCK_MINORS in defconfig
> 
> Rajendra Nayak (1):
>       arm: qcom: Enable lpass clock driver in defconfig
> 
> Stephen Boyd (1):
>       arm: qcom: Update defconfig
> 
>  arch/arm/configs/qcom_defconfig | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

I only see one new patch here, the mmc minors one. The others have already been
merged through another pull request.

Please send incremental requests in those cases so that the diffstats are
correct.

Anyway, merged.


-Olof
