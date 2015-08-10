From: fcooper@ti.com (Franklin S Cooper Jr.)
Date: Mon, 10 Aug 2015 18:47:25 -0500
Subject: [RESEND][PATCH 3/4] ARM: davinci: Set proper SPI prescale limit
 value
In-Reply-To: <55B22681.3060000@ti.com>
References: <1437568344-18889-1-git-send-email-fcooper@ti.com>
 <1437568344-18889-4-git-send-email-fcooper@ti.com> <55B22681.3060000@ti.com>
Message-ID: <55C9380D.1060802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/24/2015 06:50 AM, Sekhar Nori wrote:
> On Wednesday 22 July 2015 06:02 PM, Franklin S Cooper Jr wrote:
>> SPI Davinci driver has been updated to allow SOCs to specify their minimum
>> prescale value. Update the various SOCs board files that use this driver with
>> their proper prescaler limit.
>>
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> Acked-by: Sekhar Nori <nsekhar@ti.com>
>
> in case Mark is okay to take it through his tree. It does not clash with
> anything else I have for mach-davinci.
>
> Thanks,
> Sekhar
>
ping. Patches 1 and 2 have already been pulled into Mark's spi tree and are currently in in linux-next.
