From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 19 Aug 2015 11:16:52 -0500
Subject: [PATCH 2/3] [v4] ARM64: TTY: hvc_dcc: Add support for ARM64 dcc
In-Reply-To: <20150819101426.GB6281@e103592.cambridge.arm.com>
References: <1438992995-22610-1-git-send-email-timur@codeaurora.org>
 <1438992995-22610-2-git-send-email-timur@codeaurora.org>
 <20150810094008.GD1604@arm.com> <55D2749A.401@codeaurora.org>
 <20150818082141.GA6281@e103592.cambridge.arm.com>
 <55D3825D.6020105@codeaurora.org>
 <20150819101426.GB6281@e103592.cambridge.arm.com>
Message-ID: <55D4ABF4.5020600@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2015 05:14 AM, Dave Martin wrote:
>> >So does that mean that ldrb will zero-extend the byte to all 64 bits of x3?
> Yes.  No extra operation is required.

So my patch is actually correct as-is?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
