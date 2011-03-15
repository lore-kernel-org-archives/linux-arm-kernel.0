From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Tue, 15 Mar 2011 12:53:47 +0530
Subject: [PATCH v3 7/7] tty: add pruss SUART driver
In-Reply-To: <20110308104757.0f75409b.randy.dunlap@oracle.com>
References: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com><1299592667-21367-8-git-send-email-subhasish@mistralsolutions.com>
	<20110308104757.0f75409b.randy.dunlap@oracle.com>
Message-ID: <99FA4F65346D4615AC7C8CFEF72133E7@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Thank you for your comments.
Would really appreciate more comments and ways to fix this patch and bring 
it
up to Linux Standards.
If I have missed something/misunderstood then please let me know.


>> +config SERIAL_PRUSS_SUART
>> + depends on ARCH_DAVINCI && ARCH_DAVINCI_DA850
>> + select SERIAL_CORE
>> + tristate "PRUSS based SoftUART emulation on DA8XX"
>> + ---help---
>> + This driver emulates upto eight different UARTs on the PRUSS.
>
>                      up to
>
SG -- Ok Will do.


>> + You may modify the NR_SUARTS macro in the driver to emulate
>> + less number of UARTS as per your requirement.
>> + If not sure, mark N
>
>              mark N.
>
SG -- Ok Will do.


>> +    Enter the McASP number to use with SUART (0, 1 or 2).
>> + You will need to recompile the kernel if this is changed.
>
> The 2 help text lines should be indented the same.
>
SG - Ok will do.
 
