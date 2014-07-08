From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 07 Jul 2014 17:54:22 -0700
Subject: [PATCHv2 1/3] of: Split early_init_dt_scan into two parts
In-Reply-To: <1404266608-3274-1-git-send-email-lauraa@codeaurora.org>
References: <1404266608-3274-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <53BB413E.40900@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/1/2014 7:03 PM, Laura Abbott wrote:
> Currently, early_init_dt_scan validates the header, sets the
> boot params, and scans for chosen/memory all in one function.
> Split this up into two separate functions (validation/setting
> boot params in one, scanning in another) to allow for
> additional setup between boot params and scanning the memory.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

I haven't heard anything more on this series but the holiday weekend
in the US probably affected that.

Grant/Rob are you okay with taking this through the devicetree tree 
if this gets a few more acks or would you rather this go through
an ARM tree?

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
