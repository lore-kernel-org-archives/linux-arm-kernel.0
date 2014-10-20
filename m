From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 20 Oct 2014 05:30:08 -0700
Subject: [PATCH] ARM: mm: Refine set_memory_* functions
In-Reply-To: <1413800678-6794-1-git-send-email-js07.lee@gmail.com>
References: <1413800678-6794-1-git-send-email-js07.lee@gmail.com>
Message-ID: <54450050.5060903@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2014 3:24 AM, Jungseung Lee wrote:
> set_memory_* functions have same implementation
> without memory attribute.
>
> This is a change to reduce code size and enhance
> the readability
>
> Signed-off-by: Jungseung Lee <js07.lee@gmail.com>

Similar code for arm64 was recently merged. The functions there
were pulled out into arch/arm64/mm/pageattr.c. It would be good
if arm could match arm64 in that respect.

Thanks,
Laura


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
