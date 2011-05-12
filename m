From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 May 2011 14:54:47 +0200
Subject: [PATCH v4 1/1] can: add pruss CAN driver.
In-Reply-To: <4DCB88A4.2010901@grandegger.com>
References: <1303474267-6344-1-git-send-email-subhasish@mistralsolutions.com>
	<201105112344.44171.arnd@arndb.de>
	<4DCB88A4.2010901@grandegger.com>
Message-ID: <201105121454.47781.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 May 2011, Wolfgang Grandegger wrote:
> Well, that seems sophisticated resulting in a complex implementation
> (may code line) also because hardware filters are very hardware
> dependent. Usually just one global filter can be defined. I think that's
> overkill. A simple interface using:
> 
>   ip link set can0 type can filter <id>:<mask> [<id>:<mask> ...]
> 
> would just be fine.

Ok, fair enough. Still I would suggest you first come up with
a reasonable user interface (the one you posted may be just right,
I don't know), and then let someone do the implementation in the
pruss firmware that is the best match for the user interface, rather
than the other way around.

	Arnd
