From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Fri, 19 Aug 2016 09:38:23 -0700
Subject: [PATCH 1/1] ARM: dma: fix dma_max_pfn()
In-Reply-To: <9c38663b-1867-213d-21ba-f1dec7edfb6a@ti.com>
References: <1471435517-7840-1-git-send-email-rogerq@ti.com>
 <1471435517-7840-2-git-send-email-rogerq@ti.com>
 <20160818142459.GX1041@n2100.armlinux.org.uk>
 <8003b6ed-6071-9384-1b88-0b84604bdce8@oracle.com>
 <20160818230754.GE1041@n2100.armlinux.org.uk>
 <f8a05c02-df36-a0cf-6433-c67eb4a0f5b6@oracle.com>
 <9c38663b-1867-213d-21ba-f1dec7edfb6a@ti.com>
Message-ID: <81dedbcc-14f6-f02f-2ce9-114d57c8d9d4@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 8/19/2016 12:30 AM, Roger Quadros wrote:
> Hi Santosh,
>

>>> So I'm 99.9% convinced that the proposed change is correct.
>>>
>> I will got with that then :-) and take my objection back. Just
>> saying that if there other breakages which I can't recollect now,
>> those drivers needs to be patched as well.
>>
> I was able to boot the Keystone2 Edison EVM over NFS with the $subject patch.
> Boot log is below. Do you see anything suspicious?
>
Logs looks ok to me. Probably do some tests where DMA and bounce buffers 
etc gets tested. Running it through your internal regression
suit will be good idea as well if thats possible.

Regards,
Santosh
