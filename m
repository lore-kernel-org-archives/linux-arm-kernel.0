From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 May 2010 10:50:33 +0100
Subject: [PATCH 1/2] s3c2410_wdt - Add extra option to include watchdog
	for Samsung SoCs
In-Reply-To: <4BF65090.5010905@ru.mvista.com>
References: <1274353105-17774-1-git-send-email-ben-linux@fluff.org>
	<1274353105-17774-2-git-send-email-ben-linux@fluff.org>
	<4BF65090.5010905@ru.mvista.com>
Message-ID: <20100521095033.GA29756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 21, 2010 at 01:21:20PM +0400, Sergei Shtylyov wrote:
>>  +config HAVE_S3C2410_WATCHDOG
>> +	bool
>> +	help
>> +	  This will include watchdog timer support for Samsung SoCs. If
>> +	  you want to include watchdog support for any machine, kindly
>> +	  select this in the respective mach-XXXX/Kconfig file.
>
>    What use is the help text for a hidden option?

Documentation to describe what the hidden option does - it tells those
who modify Kconfig files what the intention of the option is.
