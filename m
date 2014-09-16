From: galak@codeaurora.org (Kumar Gala)
Date: Mon, 15 Sep 2014 19:09:54 -0700
Subject: [PATCH v4 1/3] ahci-platform: Bump max number of clocks to 5
In-Reply-To: <1410277008-20242-1-git-send-email-galak@codeaurora.org>
References: <1410277008-20242-1-git-send-email-galak@codeaurora.org>
Message-ID: <FDA51DE0-3F2C-48E3-81B7-5F2ABCEE6F61@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 9, 2014, at 8:36 AM, Kumar Gala <galak@codeaurora.org> wrote:

> Qualcomm IPQ806x SoCs with SATA controllers need 5 clocks to be enabled.
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> ---
> (reposted with Hans on list)
> 
> v4:
> * Updated to upstream changes
> 
> drivers/ata/ahci.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Any updates on these patches?

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
