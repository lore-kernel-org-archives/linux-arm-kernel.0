From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Oct 2014 23:09:39 +0200
Subject: [PATCH] ARM: qcom: Increase MMC_BLOCK_MINORS in defconfig
In-Reply-To: <1412843614-4537-1-git-send-email-gdjakov@mm-sol.com>
References: <1412843614-4537-1-git-send-email-gdjakov@mm-sol.com>
Message-ID: <2943498.xucHPVCXbF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 October 2014 11:33:34 Georgi Djakov wrote:
> There are currently more than 16 partitions on the eMMC of all recent
> Qualcomm devices. Increase the number of minors per block device to
> detect all available partitions.
> 

You should probably submit the same change for multi_v7_defconfig.

	Arnd
