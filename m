From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Fri, 18 Feb 2011 12:48:51 +0530
Subject: [PATCH v2 03/13] da850: pruss board specific additions.
In-Reply-To: <4D558337.2060401@mvista.com>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-4-git-send-email-subhasish@mistralsolutions.com>
	<4D558337.2060401@mvista.com>
Message-ID: <DB2461FECF1749F38B5F6E48D67E5A31@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--------------------------------------------------
From: "Sergei Shtylyov" <sshtylyov@mvista.com>
Sent: Saturday, February 12, 2011 12:13 AM
To: "Subhasish Ghosh" <subhasish@mistralsolutions.com>
Cc: <davinci-linux-open-source@linux.davincidsp.com>; 
<sachi@mistralsolutions.com>; "Russell King" <linux@arm.linux.org.uk>; 
"Kevin Hilman" <khilman@deeprootsystems.com>; "open list" 
<linux-kernel@vger.kernel.org>; <m-watkins@ti.com>; 
<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 03/13] da850: pruss board specific additions.

> Subhasish Ghosh wrote:
>
>> This patch adds board specific initializations and setup routines.
>
>> Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
> [...]
>
>> diff --git a/arch/arm/mach-davinci/board-da850-evm.c 
>> b/arch/arm/mach-davinci/board-da850-evm.c
>> index 11f986b..242d1ed 100644
>> --- a/arch/arm/mach-davinci/board-da850-evm.c
>> +++ b/arch/arm/mach-davinci/board-da850-evm.c
>> @@ -1053,6 +1053,26 @@ static __init int da850_evm_init_cpufreq(void)
>>  static __init int da850_evm_init_cpufreq(void) { return 0; }
>>  #endif
>>  +static struct da8xx_pruss_devices pruss_devices[] = {
>> + {.dev_name = NULL,},
>
>    No need to explicitly initialize to NULL.
>
SG - Ok, Will remove

> WBR, Sergei
> 
