From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Mon, 30 May 2011 20:08:03 +0530
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver
In-Reply-To: <20110530140231.GA11831@kroah.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<201105231730.06564.arnd@arndb.de>
	<7E10264BABCB4C1788DCD9715461BDE8@subhasishg>
	<201105241440.34854.arnd@arndb.de>
	<20110524134338.GA13491@kroah.com>
	<45A0E7B350CB4DF685D18EFE6EB1CB76@subhasishg>
	<20110530140231.GA11831@kroah.com>
Message-ID: <98F790F0AABD4248A3DBFF4BA7D926B1@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

>> >
>> How do I handle the headers. I have two header files in the
>> include/linux/mfd.
> 
> Why would they be in there for a single driver?
> 
>> Should I submit them as a separate patch into mfd.
>> 
>> These headers are also used by pruss uart implementation.
> 
> Then put them in the staging directory for your driver, why would
> anything outside of your driver need a .h file?
> 
There are two header files in the include/linux/mfd/pruss.h & pruss_core.h

the file pruss.h is included by the pruss_suart_api.c (tty uart driver) for
some data structures, defines and function prototypes. 
