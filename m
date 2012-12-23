From: mikedunn@newsguy.com (Mike Dunn)
Date: Sun, 23 Dec 2012 07:18:04 -0800
Subject: [PATCH 3/3] ARM: pxa: palmtreo: add docg4 device initialization
In-Reply-To: <50D71120.7040704@mvista.com>
References: <1356204719-3317-1-git-send-email-mikedunn@newsguy.com>
 <1356204719-3317-4-git-send-email-mikedunn@newsguy.com>
 <50D71120.7040704@mvista.com>
Message-ID: <50D720AC.40504@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/23/2012 06:11 AM, Sergei Shtylyov wrote:

>>
>>   /******************************************************************************
>> + * diskonchip docg4 flash
>> + ******************************************************************************/
>> +#if defined(CONFIG_MACH_TREO680)
>> +/* REVISIT: does the centro have this device also? */
>> +#if defined(CONFIG_MTD_NAND_DOCG4) || defined(CONFIG_MTD_NAND_DOCG4_MODULE)
> 
>    #if IS_ENABLED(CONFIG_MTD_NAND_DOCG4)
> 
> WBR, Sergei
> 


Thanks Sergei.  I see this in kconfig.h now.  This will be another patch to
replace all the "if defined" in this file.

Mike
