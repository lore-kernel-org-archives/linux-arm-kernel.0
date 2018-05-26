From: olof@lixom.net (Olof Johansson)
Date: Sat, 26 May 2018 11:58:49 -0700
Subject: [GIT PULL] Qualcomm ARM64 DT updates for 4.18 - Part 2
In-Reply-To: <1527288065-27438-1-git-send-email-andy.gross@linaro.org>
References: <1527288065-27438-1-git-send-email-andy.gross@linaro.org>
Message-ID: <20180526185849.p3e36mnvzzqtbexq@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 05:41:05PM -0500, Andy Gross wrote:
> The following changes since commit 57fc67ef0d35af11fbb1b928e359b370889994ae:
> 
>   arm64: dts: qcom: msm8996: Add ufs related nodes (2018-05-22 23:29:03 -0500)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.18-2
> 
> for you to fetch changes up to d8f8d467f53a192041193fc17176ceb013f4d041:
> 
>   arm64: dts: apq8096-db820c: Removed bt-en-1-8v regulator (2018-05-25 16:21:05 -0500)
> 
> ----------------------------------------------------------------
> Qualcomm ARM64 Updates for v4.18 Part 2
> 
> * Fix UFS GDSC on msm8996
> * Remove unused BT node regulator
> * Correct WLAN PCIe regulator endpoint name

Thanks, merged into next/dt.


-Olof
