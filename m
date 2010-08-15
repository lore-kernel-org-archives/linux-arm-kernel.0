From: claudio@evidence.eu.com (Claudio Scordino)
Date: Sun, 15 Aug 2010 16:22:13 +0200
Subject: RS485: ioctls defined twice ?
Message-ID: <4C67F815.8020808@evidence.eu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

	is there any reason why ioctls TIOCGRS485 and TIOCSRS485 are defined (with the same values) in both include/asm-generic/ioctls.h and arch/arm/include/asm/ioctls.h ?

The same happens also for avr32, powerpc and cris (which, however, defines a different value for TIOCSRS485).

Is it duplicated code ?

Or should these values stay in both asm/ioctls.h and asm-generic/ioctls.h ?

Many thanks,

	Claudio
