From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Wed, 27 Apr 2011 12:13:12 +0530
Subject: [PATCH v4 03/11] da850: pruss platform specific additions.
In-Reply-To: <4DB6A736.3030609@mvista.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<1303474109-6212-4-git-send-email-subhasish@mistralsolutions.com>
	<4DB6A736.3030609@mvista.com>
Message-ID: <0A4FA4CFE83C4DD4BA36491027E93552@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>>   #include<mach/edma.h>
>> @@ -73,6 +75,7 @@ extern unsigned int da850_max_speed;
>>   #define DA8XX_DDR2_CTL_BASE 0xb0000000
>>   #define DA8XX_ARM_RAM_BASE 0xffff0000
>>   #define DA8XX_SHARED_RAM_BASE 0x80000000
>> +#define DA8XX_PRUSS_MEM_BASE 0x01C30000
>
>    Keep the list sorted please. Also, this macro doesn't seem used outside 
> devices-da8xx.c, so should be moved there...

SG - But would it not be better to have all device addresses at the same 
place.
 
