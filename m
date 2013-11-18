From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 18 Nov 2013 14:04:50 -0500
Subject: [PATCH] ARM: move firmware_ops to drivers/firmware
In-Reply-To: <20131118173047.GF9838@arm.com>
References: <1384678169-28228-1-git-send-email-acourbot@nvidia.com>
 <CAHkRjk5LBOFx3ir49RgEsaFwvp5UCpTjYFWto+URXebAsOP0RA@mail.gmail.com>
 <52898417.80601@nvidia.com> <20131118115842.GE4050@arm.com>
 <528A4869.2020701@wwwdotorg.org> <20131118173047.GF9838@arm.com>
Message-ID: <528A64D2.4020107@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 11/18/2013 12:30 PM, Catalin Marinas wrote:
[...]
> You can't run legacy AArch32 code at EL3 and have lower levels in AArch64
> mode (architectural constraint).

What prevents AArch32 code from running at EL3 and then requesting a reset to
AArch64 by writing to the Reset Management Register before sliding down to
lower exception levels?

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
