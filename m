From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 6 May 2010 15:19:37 -0500
Subject: [PATCH] mach-ep93xx: checkpatch.pl cleanup
In-Reply-To: <4BE323A3.4040601@bluewatersys.com>
References: <0D753D10438DA54287A00B0270842697636ECB4F3D@AUSP01VMBX24.collaborationhost.net>
	<4BE323A3.4040601@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B0270842697636ECB51E0@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, May 06, 2010 1:17 PM, Ryan Mallon wrote:
> H Hartley Sweeten wrote:
>> This cleans up most the checkpatch.pl issues in mach-ep93xx.
>> 
>>   ERROR: space required after that ',' (ctx:VxV)
>>   WARNING: line over 80 characters
>>   WARNING: please, no space before tabs
>> 
>> The file core.c still produces this warning:
>> 
>>   WARNING: externs should be avoided in .c files
>> 
>> Due to two externs declared for functions in located in gpio.c.
>> Since these are __init functions, and not meant to be exposed,
>> these warnings were not fixed.
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Ryan Mallon <ryan@bluewatersys.com>
>
> I actually think this makes the file less readable in most cases:

Not a problem.  I just happened to run the script to see what happened.
I'll just leave everything as-is for now.

Thanks,
Hartley
