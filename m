From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 12 Feb 2014 16:54:07 -0800
Subject: [RFC/PATCH 2/3] arm: Add ARCH_WANT_OF_RANDOMNESS
In-Reply-To: <20140212164907.0E958C407C9@trevor.secretlab.ca>
References: <1392168805-14200-1-git-send-email-lauraa@codeaurora.org> <
 1392168805-14200-3-git-send-email-lauraa@codeaurora.org>
 <20140212164907.0E958C407C9@trevor.secretlab.ca>
Message-ID: <52FC17AF.1080508@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/12/2014 8:49 AM, Grant Likely wrote:
> On Tue, 11 Feb 2014 17:33:24 -0800, Laura Abbott <lauraa@codeaurora.org> wrote:
>> The stack canary for ARM is currently the same across reboots
>> due to lack of randomness early enough. Add ARCH_WANT_OF_RANDOMNESS
>> to allow devices to add whatever randomness they need.
>>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>
> Do you have a draft patch for a user of this yet?
>

I had a particular patch in mind but I need to re-work it to work with 
the upstream tree. I wanted to at least send out the infrastructure to 
see how open people were to the idea. After reading the comments, I have 
a couple more ideas of users as well. I'll see if I can work that in for v2.

> g.
>

Thanks,
Laura


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
