From: claudio@evidence.eu.com (Claudio Scordino)
Date: Wed, 11 Aug 2010 21:58:57 +0200
Subject: [PATCH] Documentation about RS485 serial communications
In-Reply-To: <20100811083214.21d2919e.randy.dunlap@oracle.com>
References: <4BB053C4.7050700@evidence.eu.com>	<4BB10304.6090006@bluewatersys.com>	<4BB1BF49.2000609@evidence.eu.com>	<4BB252E3.3030703@bluewatersys.com>	<4BBD8C9D.3070401@evidence.eu.com>	<20100408111310.524f7354@lxorguk.ukuu.org.uk>	<4BBDD71D.1010700@evidence.eu.com>	<4BFD1FB6.8050405@atmel.com>	<4BFE2F38.8050200@evidence.eu.com>	<4BFE41FD.2080804@atmel.com>	<20100527102917.GB31253@pengutronix.de>	<4C626CBF.9020609@evidence.eu.com>
	<20100811083214.21d2919e.randy.dunlap@oracle.com>
Message-ID: <4C630101.50205@evidence.eu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Best regards,

	Claudio
