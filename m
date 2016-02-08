From: olof@lixom.net (Olof Johansson)
Date: Mon, 8 Feb 2016 13:30:18 -0800
Subject: [PATCH] arm64: defconfig: Add Qualcomm sdhci and restart
 functionality
In-Reply-To: <1454581976-25364-1-git-send-email-georgi.djakov@linaro.org>
References: <1454581976-25364-1-git-send-email-georgi.djakov@linaro.org>
Message-ID: <20160208213018.GB25468@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 12:32:56PM +0200, Georgi Djakov wrote:
> Enable sdhci and restart functionality for devices based on msm8916 platform.
> Also increase the number of minors per block device to detect all available
> partitions.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

What's this patch against? It doesn't apply on top of v4.5-rc3. Please rebase
against our next/arm64 branch and resend.


Thanks!


-Olof
