From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 9 Nov 2015 07:48:25 -0600
Subject: [PATCH V3 3/4] dmaselftest: add memcpy selftest support functions
In-Reply-To: <56400909.2090300@codeaurora.org>
References: <1446958380-23298-1-git-send-email-okaya@codeaurora.org>
 <1446958380-23298-4-git-send-email-okaya@codeaurora.org>
 <563EDA15.7070606@codeaurora.org> <56400909.2090300@codeaurora.org>
Message-ID: <5640A429.6090302@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sinan Kaya wrote:
>>
>> And why kmalloc anyway?  Why not leave it on the stack?
>>
>>      char src[] = "hello world";
>>
>> ?
>
> I need to call dma_map_single on this address to convert it to a DMA
> address. That's why.

And you can't do that with an object that's on the stack?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
