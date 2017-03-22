From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 22 Mar 2017 20:56:14 +0300
Subject: [PATCH v2 1/3] ata: add Palmchip BK3710 PATA controller driver
In-Reply-To: <1819267.Nm9hpTOhuY@amdc3058>
References: <1489509414-11491-1-git-send-email-b.zolnierkie@samsung.com>
 <1489509414-11491-2-git-send-email-b.zolnierkie@samsung.com>
 <8fc9171f-15b7-2c6a-d0b5-3af21cc88405@ti.com>
 <CGME20170322174917epcas1p1a4ba3e4da231ee3b7784cb0c669611ed@epcas1p1.samsung.com>
 <1819267.Nm9hpTOhuY@amdc3058>
Message-ID: <65ecf56a-7e45-30d3-649c-798f8037a636@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 03/22/2017 08:49 PM, Bartlomiej Zolnierkiewicz wrote:

>>> Add Palmchip BK3710 PATA controller driver.
>>>
>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>
>> There are some checkpatch suggestions that are worth fixing, I think.
>>
>> [PATCH v2 1_3] ata: add Palmchip BK3710 PATA controller driver - Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> - 2017-03-14 2206.eml:277: CHECK: Alignment should match open parenthesis
>> [PATCH v2 1_3] ata: add Palmchip BK3710 PATA controller driver - Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> - 2017-03-14 2206.eml:320: CHECK: Alignment should match open parenthesis
>> [PATCH v2 1_3] ata: add Palmchip BK3710 PATA controller driver - Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> - 2017-03-14 2206.eml:489: CHECK: Comparison to NULL could be written "!mem"
>
> Will be fixed in v3, thanks.
>
> [ My scripts didn't run checkpatch with --strict so I haven't noticed them. ]

   --strict'ly speaking, this switch is only forced on in the networking 
trees. :-)

> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics

MBR, Sergei
