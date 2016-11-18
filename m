From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 23:37:11 -0800
Subject: [GIT PULL] Qualcomm ARM64 DT Updates for v4.10
In-Reply-To: <1479017736-13564-2-git-send-email-andy.gross@linaro.org>
References: <1479017736-13564-1-git-send-email-andy.gross@linaro.org>
 <1479017736-13564-2-git-send-email-andy.gross@linaro.org>
Message-ID: <20161118073711.GM1785@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 13, 2016 at 12:15:32AM -0600, Andy Gross wrote:
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.10
> 
> for you to fetch changes up to feeaf56ac78d283efe65ea60ec999d4bf3cf395e:
> 
>   arm64: dts: msm8994 SoC and Huawei Angler (Nexus 6P) support (2016-11-12 22:57:56 -0600)
> 
> ----------------------------------------------------------------
> Qualcomm ARM64 Updates for v4.10
> 
> * Add Hexagon SMD/PIL nodes
> * Add DB820c PMIC pins
> * Fixup APQ8016 voltage ranges
> * Add various MSM8996 nodes to support SMD/SMEM/SMP2P
> * Add support for Huawei Nexus 6P (Angler)
> * Add support for LG Nexus 5x (Bullhead)

Merged, thanks. Great to start seeing (almost) current phone support, even if
it's very basic hardware descriptions so far.



-Olof
