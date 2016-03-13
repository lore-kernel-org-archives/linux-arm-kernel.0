From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Mar 2016 16:16:38 -0800
Subject: [PATCH v3 1/2] arm64: defconfig: Add Qualcomm sdhci and restart
 functionality
In-Reply-To: <1456397192-2407-1-git-send-email-georgi.djakov@linaro.org>
References: <1456397192-2407-1-git-send-email-georgi.djakov@linaro.org>
Message-ID: <20160313001638.GE17502@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 12:46:31PM +0200, Georgi Djakov wrote:
> Enable sdhci and restart functionality for devices based on msm8916 platform.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> Changes since v2:
>  * Move the MMC_BLOCK_MINORS change into a separate patch.
> 
> Changes since v1:
>  * Rebased onto arm-soc/next/arm64

Thanks, applied.


-Olof
