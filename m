From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 13 Oct 2015 11:39:30 -0700
Subject: [PATCH 09/10] clk: ns2: add clock support for Broadcom Northstar
 2 SoC
In-Reply-To: <561D36A6.2080309@broadcom.com>
References: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
 <1443826665-17570-10-git-send-email-jonmason@broadcom.com>
 <20151010003352.GA26883@codeaurora.org> <20151012181929.GG20867@broadcom.com>
 <561D36A6.2080309@broadcom.com>
Message-ID: <561D4FE2.4020805@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/13/2015 09:51 AM, Scott Branden wrote:
>
> Is that really necessary at all  I think something like this work
> instead?
>
> -obj-$(CONFIG_ARCH_BCM)            += bcm/
> +obj-y        += bcm/
>
>

Yes that's fine too, as long as we don't add any obj-y inside bcm/Makefile

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
