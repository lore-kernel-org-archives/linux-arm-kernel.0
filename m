From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Mon, 30 May 2011 19:43:07 +0530
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver
In-Reply-To: <201105301604.38026.arnd@arndb.de>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<20110524134338.GA13491@kroah.com>
	<45A0E7B350CB4DF685D18EFE6EB1CB76@subhasishg>
	<201105301604.38026.arnd@arndb.de>
Message-ID: <2AF43CEDFDB649AE946E8F9F98A5AE48@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Monday 30 May 2011, Subhasish Ghosh wrote:
>> > Ah, forgot the TODO on the list of rules, I'll have to add that next
>> > time.
>> >
>> How do I handle the headers. I have two header files in the
>> include/linux/mfd.
>>
>> Should I submit them as a separate patch into mfd.
>>
>> These headers are also used by pruss uart implementation.
>
> During the time when the drivers are in staging, all files need to
> be in the same directory, including the header and the drivers using it.
> They can get moved at the time when the driver gets turned into
> a regular non-staging driver.

OK, so the UART implementation needs to be moved into staging as well ?

And what about the boardfile changes, array of mfd_cells implementation etc. 
