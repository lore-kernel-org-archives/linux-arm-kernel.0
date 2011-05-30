From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 May 2011 16:04:37 +0200
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver
In-Reply-To: <45A0E7B350CB4DF685D18EFE6EB1CB76@subhasishg>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<20110524134338.GA13491@kroah.com>
	<45A0E7B350CB4DF685D18EFE6EB1CB76@subhasishg>
Message-ID: <201105301604.38026.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 May 2011, Subhasish Ghosh wrote:
> > Ah, forgot the TODO on the list of rules, I'll have to add that next
> > time.
> > 
> How do I handle the headers. I have two header files in the
> include/linux/mfd.
> 
> Should I submit them as a separate patch into mfd.
> 
> These headers are also used by pruss uart implementation. 

During the time when the drivers are in staging, all files need to
be in the same directory, including the header and the drivers using it.
They can get moved at the time when the driver gets turned into
a regular non-staging driver.

	Arnd
