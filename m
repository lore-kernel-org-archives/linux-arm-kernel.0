From: sricharan@codeaurora.org (Sricharan)
Date: Sun, 4 Dec 2016 13:18:56 +0530
Subject: [RESEND PATCH V6 0/6] Add support for privileged mappings
In-Reply-To: <e7e05493-e216-d744-b828-351d2c70150d@arm.com>
References: <1480690509-13490-1-git-send-email-sricharan@codeaurora.org>
 <e7e05493-e216-d744-b828-351d2c70150d@arm.com>
Message-ID: <000d01d24e02$e3023700$a906a500$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

>Hi Sricharan,
>
>On 02/12/16 14:55, Sricharan R wrote:
>> This series is a resend of the V5 that Mitch sent sometime back [2]
>> All the patches are the same and i have just rebased. Not sure why this
>> finally did not make it last time. The last patch in the previous
>> series does not apply now [3], so just redid that. Also Copied the tags
>> that he had from last time as well.
>
>Heh, I was assuming this would be down to me to pick up. Vinod did have
>some complaints last time about the commit message on the PL330 patch -
>I did get as far as rewriting that and reworking onto my SMMU
>changes[1], I just hadn't got round to sending it, so it fell onto the
>"after the next merge window" pile.
>
>I'd give some review comments, but they'd essentially be a diff against
>that branch :)
>

Sure, i did not knew that you were on this already. I can repost with the diff
from your branch taken in or wait for you as well. I am fine with either ways
that you suggest.

I checked the patches against your branch, i see that the changes are,

1) one patch for implementing it for armv7s descriptor
2) Changes on pl330 patch commit logs and
3) One patch for doing the revert on arm-smmuv3 as well.

Regards,
 Sricharan
