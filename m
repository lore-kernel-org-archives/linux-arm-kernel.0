From: randy.dunlap@oracle.com (Randy Dunlap)
Date: Wed, 11 Aug 2010 20:23:09 -0000
Subject: [PATCH] Documentation about RS485 serial communications
Message-ID: <77d8ceaa-53b7-4bd2-b3ca-cd825fb61ce8@default>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----- Original Message -----
From: claudio@evidence.eu.com
To: randy.dunlap at oracle.com
Sent: Wednesday, August 11, 2010 12:59:08 PM GMT -08:00 US/Canada Pacific
Subject: Re: [PATCH] Documentation about RS485 serial communications

Hi Randy,

	thank you for the feedback.

[...]

> 
> TIOC[SG]RS485 are #defined in <asm-generic/ioctls.h>, so
> #include <asm-generic/ioctls.h>
> here and/or below (in userspace program).
> 

I noticed that for some architectures (e.g., cris) these ioctls are defined also in arch/cris/include/asm/ioctls.h, and with different values with respect to the values defined on asm-generic/ioctls.h.

Therefore, I wasn't completely sure that the values defined in asm-generic are being used in every driver...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Oh, OK, I see.  Thanks for the info.

~Randy
