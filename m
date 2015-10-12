From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 12 Oct 2015 14:20:38 -0700
Subject: [PATCH 2/5] mtd: nand: Allow MTD_NAND_BRCMNAND to be selected
 for ARM64
In-Reply-To: <1443808606-21203-3-git-send-email-anup.patel@broadcom.com>
References: <1443808606-21203-1-git-send-email-anup.patel@broadcom.com>
 <1443808606-21203-3-git-send-email-anup.patel@broadcom.com>
Message-ID: <20151012212038.GP107187@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 11:26:43PM +0530, Anup Patel wrote:
> The BRCM NAND driver can be re-used for Broadcom ARM64 SoCs hence
> this patch updates Kconfig to allow selection of MTD_NAND_BRCMNAND
> for ARM64.
> 
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Pramod KUMAR <pramodku@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

Pushed to l2-mtd.git
