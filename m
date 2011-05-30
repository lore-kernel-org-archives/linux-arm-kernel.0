From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Mon, 30 May 2011 18:55:12 +0530
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver
In-Reply-To: <20110524134338.GA13491@kroah.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<201105231730.06564.arnd@arndb.de>
	<7E10264BABCB4C1788DCD9715461BDE8@subhasishg>
	<201105241440.34854.arnd@arndb.de>
	<20110524134338.GA13491@kroah.com>
Message-ID: <45A0E7B350CB4DF685D18EFE6EB1CB76@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

> There really are only 3 rules:
> - proper license
> - self-contained in a drivers/staging/DRIVER_NAME/ directory
> - must properly build
> 
>> Mainly, this includes having a patch that adds a single
>> directory with all the driver files under drivers/staging.
>> The driver must be able to compile without errors and you need
>> a TODO file listing the remaining issues that prevent you
>> from having a non-staging driver.
> 
> Ah, forgot the TODO on the list of rules, I'll have to add that next
> time.
> 
How do I handle the headers. I have two header files in the
include/linux/mfd.

Should I submit them as a separate patch into mfd.

These headers are also used by pruss uart implementation. 
