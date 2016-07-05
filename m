From: olof@lixom.net (Olof Johansson)
Date: Mon, 4 Jul 2016 22:39:07 -0700
Subject: [GIT PULL] Qualcomm Device Tree Changes for v4.8
In-Reply-To: <1467082795-23207-1-git-send-email-andy.gross@linaro.org>
References: <1467082795-23207-1-git-send-email-andy.gross@linaro.org>
Message-ID: <20160705053907.GU1669@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2016 at 09:59:55PM -0500, Andy Gross wrote:
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dt-for-4.8
> 
> for you to fetch changes up to c3d5313001b0c8e9f70807e58438c3dcd30a4817:
> 
>   dts: ipq4019: support ARMv7 PMU (2016-06-27 17:37:00 -0500)
> 
> ----------------------------------------------------------------
> Qualcomm Device Tree Changes for v4.8
> 
> * Reverse BAM dma node reverts
> * Add BAM remote control options for affected platforms
> * Enable peripherals on APQ8074 dragonboard
> * Enable PMA8084 pwrky
> * Fix PMIC reg entries by removing unnecessary size element
> * Add SCM binding and support for all currently supported boards
> * Add Qualcomm WCNSS binding documentation
> * Rename db600c to SD_600eval and add peripheral nodes
> * Remove gpio key entry from Nexus7
> * Add APQ8060 based dragonboard and associated peripherals
> * Add ARMv7 PMU for IPQ4019
> * Update smem state cells to match documentation

Merged, thanks.


-Olof
