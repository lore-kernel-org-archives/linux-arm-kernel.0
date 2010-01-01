From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 1 Jan 2010 18:35:40 +0800
Subject: [PATCH] ARM: NUC900: rename mtd nand driver name
In-Reply-To: <20100101102708.AFB373F6FF@gemini.denx.de>
References: <4B3DC883.5060405@gmail.com>
	<20100101102708.AFB373F6FF@gemini.denx.de>
Message-ID: <e68bb3471001010235p4694f1fdgba4bf5d3a432e0c8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/1/1 Wolfgang Denk <wd@denx.de>:
> Dear Wan ZongShun,
>
> In message <4B3DC883.5060405@gmail.com> you wrote:
>> Dear David,
>>
>> Due to I have renamed the platform_device.name,so this patch changes
>> this nand driver platform_driver name.
>>
>> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
>>
>> ---
>> ?drivers/mtd/nand/w90p910_nand.c | ? ?4 ++--
>> ?1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/w90p910_nand.c
>> b/drivers/mtd/nand/w90p910_nand.c
>> index 7680e73..c2e9b68 100644
>> --- a/drivers/mtd/nand/w90p910_nand.c
>> +++ b/drivers/mtd/nand/w90p910_nand.c
>> @@ -358,7 +358,7 @@ static struct platform_driver w90p910_nand_driver = {
>> ? ? ? .probe ? ? ? ? ?= w90p910_nand_probe,
>> ? ? ? .remove ? ? ? ? = __devexit_p(w90p910_nand_remove),
>> ? ? ? .driver ? ? ? ? = {
>> - ? ? ? ? ? ? .name ? = "w90p910-fmi",
>> + ? ? ? ? ? ? .name ? = "nuc900-fmi",
>> ? ? ? ? ? ? ? .owner ?= THIS_MODULE,
>> ? ? ? },
>
> Maybe you also want to rename the file w90p910_nand.c => nuc900_nand.c ?
>

Thanks, above is my preferring, if more folks feel it is significative.

> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH, ? ? MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
> As far as the laws of mathematics refer ?to ?reality, ?they ?are ?not
> certain; ?and ?as ?far ?as ?they ?are ?certain, ?they do not refer to
> reality. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? -- Albert Einstein
>



-- 
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
