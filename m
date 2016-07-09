From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Fri, 08 Jul 2016 19:09:13 -0700
Subject: [PATCH 0/3] Add support for privileged mappings
In-Reply-To: <20160707205820.GA752@jcrouse-lnx.qualcomm.com> (Jordan Crouse's
 message of "Thu, 7 Jul 2016 14:58:21 -0600")
References: <20160706235136.27854-1-mitchelh@codeaurora.org>
 <20160707170026.GG20682@arm.com>
 <20160707205820.GA752@jcrouse-lnx.qualcomm.com>
Message-ID: <vnkwmvlrtvee.fsf@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07 2016 at 02:58:21 PM, Jordan Crouse <jcrouse@codeaurora.org> wrote:
>> Whilst this series is a step in the right direction for fixing that, I
>> don't think you can claim that only low-level users need this, given that
>> we have in-tree code which would break without it. Perhaps you just need
>> to extend things slightly more to expose this to the DMA API as well (or,
>> alternatively, hack the PL330 driver some how).
>
> I agree that hacking the DMA api would be the best long term solution but there
> be dragons there. Perhaps a workable compromise might be to white-list
> privileged aware devices via the device tree.

I'm sending a v2 with an attempt at plumbing this through the DMA layer.
Hopefully avoiding dragons while I'm at it :)


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
