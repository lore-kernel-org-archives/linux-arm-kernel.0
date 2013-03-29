From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 29 Mar 2013 10:57:14 -0400
Subject: [PATCH v2 00/30] Port of KVM to arm64
In-Reply-To: <1364317285-20937-1-git-send-email-marc.zyngier@arm.com>
References: <1364317285-20937-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <5155ABCA.4020803@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 03/26/2013 01:00 PM, Marc Zyngier wrote:
> This series contains the second version of KVM for arm64. It depends
> on the "pre-arm64 rework" series I posted initially (already in RMK's
> tree), the tiny perf patch sent just after (already in Christoffer's
> tree), and yet another 32bit rework patch ("ARM: KVM: promote vfp_host
> pointer to generic host cpu context").

In my opinion things look good. Feel free to add the following to these patches.

Reviewed-by: Christopher Covington <cov@codeaurora.org>

[...]

Cheers,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
