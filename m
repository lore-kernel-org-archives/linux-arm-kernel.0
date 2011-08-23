From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 23 Aug 2011 11:14:38 +0100
Subject: [PATCH] atmel_serial: RS485: receiving enabled when sending data
In-Reply-To: <4E537BB3.60001@evidence.eu.com>
References: <4E492CFF.7040905@pwrnet.de> <20110822211832.GA8023@kroah.com>
	<4E536536.3030004@evidence.eu.com>
	<20110823093035.GB19622@n2100.arm.linux.org.uk>
	<4E537BB3.60001@evidence.eu.com>
Message-ID: <20110823111438.5d6b286d@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> atmel_serial: RS485: receiving enabled when sending data
> 
> By default the atmel_serial driver in RS485 mode disables receiving data until
> all data in the send buffer has been sent. This flag allows to receive data
> even whilst sending data.
> 
> Signed-off-by: Bernhard Roth <br@pwrnet.de> 
> Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>

Acked-by: Alan Cox <alan@linux.intel.com>

(although when we have people having a serious meta discussion about four
 spaces, or a tab or neither rather than functionality I despair)

This is sensible functionality and relevant to various interfaces so
makes sense.
