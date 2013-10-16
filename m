From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 16 Oct 2013 13:48:50 -0400
Subject: [PATCH 1/2] ARM: vexpress: Make defconfig work again
In-Reply-To: <1381930594-1701-2-git-send-email-pawel.moll@arm.com>
References: <1381930594-1701-1-git-send-email-pawel.moll@arm.com>
 <1381930594-1701-2-git-send-email-pawel.moll@arm.com>
Message-ID: <525ED182.6080505@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel, Fathi,

On 10/16/2013 09:36 AM, Pawel Moll wrote:
> From: Fathi Boudra <fathi.boudra@linaro.org>
> 
> This patch updates the Versatile Express defconfig to a level
> which makes it possible to run a defconfig-ed kernel work
> on the board and in QEMU with modern userspace. It does:
> 
> - update cmdline to contain "console=ttyAMA0" only
> - enable devtmpfs filesystem
> - enable voltage regulator support
> - enable ext4 filesystem
> - disable low level debug and early printk
> 
> Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
> [PM: removed DEBUG_LL - it doesn't work on qemu]

Does DEBUG_LL/EARLY_PRINTK break boot on QEMU? If not, why not leave it in for
folks using other emulators, hardware, and maybe future versions of QEMU?

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
