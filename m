From: sricharan@codeaurora.org (Sricharan R)
Date: Thu, 6 Apr 2017 15:05:31 +0530
Subject: [PATCH V10 03/12] of: dma: Move range size workaround to
 of_dma_get_range()
In-Reply-To: <58E5DF13.2020700@gmail.com>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-4-git-send-email-sricharan@codeaurora.org>
 <58E5DF13.2020700@gmail.com>
Message-ID: <4b56ef2a-3ede-6093-69d9-576b6e73ea44@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

On 4/6/2017 11:54 AM, Frank Rowand wrote:
> On 04/04/17 03:18, Sricharan R wrote:
>> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>
>> Invalid dma-ranges values should be worked around when retrieving the
>> DMA range in of_dma_get_range(), not by all callers of the function.
>> This isn't much of a problem now that we have a single caller, but that
>> situation will change when moving DMA configuration to device probe
>> time.
>
> Please drop this patch from the series.  I just now sent Rob an
> alternative that reflects other changes that have occurred since
> this patch series was first created many, many moons ago
> (https://lkml.org/lkml/2017/4/6/53).

ok, would drop this.

Regards,
  Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
