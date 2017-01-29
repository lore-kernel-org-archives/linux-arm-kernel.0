From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 15:10:28 -0800
Subject: [GIT PULL] Qualcomm ARM64 DT Updates for v4.11
In-Reply-To: <1485240494-8040-1-git-send-email-andy.gross@linaro.org>
References: <1485240494-8040-1-git-send-email-andy.gross@linaro.org>
Message-ID: <20170129231028.GL3133@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 12:48:10AM -0600, Andy Gross wrote:
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.11
> 
> for you to fetch changes up to 3a52153975f7e2cda90ad36f3a63104610da657f:
> 
>   arm64: dts: db820c: add support to volume up key (2017-01-13 13:17:29 -0600)
> 
> ----------------------------------------------------------------
> Qualcomm ARM64 Updates for v4.11
> 
> * Add Vol+ support for DB820C and APQ8016
> * Add HDMI audio support for APQ8016
> * Fix DB820C GPIO pinctrl name
> * Enable WCNSS on MSM8916
> * Add SCM node for MSM8996
> * Use fixed XO clock on MSM8916
> 
> ----------------------------------------------------------------
> Bjorn Andersson (1):
>       ARM: dts: msm8916: Add and enable wcnss node
> 
> Georgi Djakov (1):
>       arm64: dts: qcom: msm8916: Use fixed factor xo clock
> 
> Ivan T. Ivanov (2):
>       arm64: dts: apq8016-sbc: Add Volume Up key device node
>       arm64: dts: apq8016-sbc: Limit MPP4 high state to 1.8V
> 
> Srinivas Kandagatla (3):
>       arm64: dts: db820c: fix gpio pinctrl name correctly
>       arm64: dts: apq8016-sbc: add support to hdmi audio via adv7533
>       arm64: dts: db820c: add support to volume up key
> 
> spjoshi at codeaurora.org (1):
>       arm64: dts: msm8996: Add SCM DT node

Merged, but please keep an eye on ARM vs arm64 patch subjects.


-Olof
