From: olof@lixom.net (Olof Johansson)
Date: Mon, 12 Nov 2018 10:15:24 -0800
Subject: [GIT PULL] Qualcomm ARM64 DT Fixes for 4.20-rc1
In-Reply-To: <1541807491-13259-1-git-send-email-andy.gross@linaro.org>
References: <1541807491-13259-1-git-send-email-andy.gross@linaro.org>
Message-ID: <20181112181524.5kri2mkxfqflm5pl@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2018 at 05:51:31PM -0600, Andy Gross wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-fixes-for-4.20-rc1
> 
> for you to fetch changes up to 9134586715e389fe90d9d28cb37a668f374d686a:
> 
>   arm64: dts: qcom: msm8998: Reserve gpio ranges on MTP (2018-11-09 17:17:53 -0600)
> 
> ----------------------------------------------------------------
> Qualcomm ARM64 DT Fixes for 4.20-rc1
> 
> * Fix reserved gpio ranges for SDM845 and MSM8998

Could be good to find out in the tag text what problems this fixes.

> ----------------------------------------------------------------
> Bjorn Andersson (2):
>       arm64: dts: sdm845-mtp: Reserve reserved gpios
>       arm64: dts: qcom: msm8998: Reserve gpio ranges on MTP

Merged, thanks!


-Olof
