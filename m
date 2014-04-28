From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 28 Apr 2014 16:30:44 -0700
Subject: [PATCH] mfd: pm8921: Remove pm8xxx API now that sub-devices use
 regmap
In-Reply-To: <1397002455-12854-1-git-send-email-sboyd@codeaurora.org>
References: <1397002455-12854-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <535EE4A4.6040208@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/14 17:14, Stephen Boyd wrote:
> The pm8xxx read/write wrappers are no longer necessary now that
> all the sub-device drivers are using the regmap API. Remove it.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>
> Based on Linus' tip as of a7963eb7f4c4 (Merge branch 'for_linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs, 2014-04-07)

ping?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
