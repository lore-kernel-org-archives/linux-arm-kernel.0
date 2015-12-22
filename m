From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 12:21:20 -0800
Subject: [GIT PULL] Qualcomm ARM64 Updates for v4.5
In-Reply-To: <1450384464-4421-1-git-send-email-andy.gross@linaro.org>
References: <1450384464-4421-1-git-send-email-andy.gross@linaro.org>
Message-ID: <20151222202120.GO30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 02:34:24PM -0600, Andy Gross wrote:
> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
> 
>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.5
> 
> for you to fetch changes up to 9e1dfb858de43bb3dfbbb32cec57433e9b250dee:
> 
>   arm64: dts: Add PM8916 support on MSM8916 (2015-12-16 23:01:44 -0600)
> 
> ----------------------------------------------------------------
> Qualcomm ARM64 Updates for v4.5
> 
> * Add fixed rate oscillators to dts
> * Fixup PMIC alias and properties
> * Change 8916-MTP compatible to be compliant with new scheme
> * Fix 8x16 UART pinctrl configuration
> * Add SMEM, RPM/SMD, and PM8916 support on MSM8916

Merged into next/dt64, thanks.


-Olof
