From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 16:08:38 -0800
Subject: [GIT PULL] Qualcomm Driver Updates for v4.11
In-Reply-To: <1485240494-8040-3-git-send-email-andy.gross@linaro.org>
References: <1485240494-8040-1-git-send-email-andy.gross@linaro.org>
 <1485240494-8040-3-git-send-email-andy.gross@linaro.org>
Message-ID: <20170130000838.GN3133@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 12:48:12AM -0600, Andy Gross wrote:
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.11
> 
> for you to fetch changes up to a811b420b6c13759540070c0e9541b7cd8569168:
> 
>   firmware: qcom_scm: Add set remote state API (2017-01-16 23:45:04 -0600)
> 
> ----------------------------------------------------------------
> Qualcomm ARM Based Driver Updates for v4.11
> 
> * Fix issues with SCM compile testing
> * Add SCM set remote state API
> * Mask APQ8064 SCM clock dependency issue
> * Add Qualcomm DMA folder to MAINTAINERS
> * Fix EBI2 dependencies
> 
> ----------------------------------------------------------------
> Andy Gross (2):
>       firmware: qcom: scm: Mask APQ8064 core clk dependency
>       firmware: qcom_scm: Add set remote state API
> 
> Linus Walleij (1):
>       bus: qcom_ebi2: default y if ARCH_QCOM
> 
> Pramod Gurav (1):
>       MAINTAINERS: Update the files to include the Qualcomm DMA folder
> 
> Stanimir Varbanov (1):
>       firmware: qcom: scm: Add empty functions to help compile testing

Merged, thanks.


-Olof
