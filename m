From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 12:19:47 -0800
Subject: [PATCH v2] arm64: defconfig: Add Qualcomm sdhci and restart
 functionality
In-Reply-To: <1455013185-946-1-git-send-email-georgi.djakov@linaro.org>
References: <1455013185-946-1-git-send-email-georgi.djakov@linaro.org>
Message-ID: <20160224201947.GD10126@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 09, 2016 at 12:19:45PM +0200, Georgi Djakov wrote:
> Enable sdhci and restart functionality for devices based on msm8916 platform.
> Also increase the number of minors per block device to detect all available
> partitions.

Title is unfortunately misleading. Please do two patches, or update the title.


-Olof
