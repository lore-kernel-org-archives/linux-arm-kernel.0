From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 25 Feb 2015 11:56:36 -0500
Subject: [PATCH v10 4/6] ARM: add vdso user-space code
In-Reply-To: <20150224101754.GA27420@e104818-lin.cambridge.arm.com>
References: <1411413485-7675-1-git-send-email-nathan_lynch@mentor.com>
 <1411413485-7675-5-git-send-email-nathan_lynch@mentor.com>
 <loom.20150213T053547-381@post.gmane.org>
 <20150213105447.GB3508@e104818-lin.cambridge.arm.com>
 <loom.20150213T124417-857@post.gmane.org> <20150213141425.GA4713@localhost>
 <loom.20150213T153239-809@post.gmane.org>
 <20150213153253.GA23801@e104818-lin.cambridge.arm.com>
 <loom.20150218T122348-60@post.gmane.org> <54E7AC90.40209@codeaurora.org>
 <20150224101754.GA27420@e104818-lin.cambridge.arm.com>
Message-ID: <54EDFEC4.7060600@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 02/24/2015 05:17 AM, Catalin Marinas wrote:

[snip]

> Writing CNTFRQ from non-secure mode would trap as well.

Are you saying it could A) cause an exception targeting the current EL/mode
but not others, or B) cause an exception targeting the current or another EL/mode?

[snip]

> The detection mechanism would have to involve trapping of an undefined
> instruction but it doesn't need to be done early during boot.

I put detection during early boot because I wanted to potentially change
ELs/modes during early boot.

Thanks,
Chris

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
