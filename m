From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 12 Oct 2009 23:29:23 -0400 (EDT)
Subject: [PATCH v2] OpenRD base: Initialize PCI express and i2c
In-Reply-To: <200910090851.44868.dk-arm-linux@gmx.de>
References: <200910081333.43065.dk-arm-linux@gmx.de>
	<alpine.LFD.2.00.0910081337260.18779@xanadu.home>
	<20091009082645.7e37573d@marrow.netinsight.se>
	<200910090851.44868.dk-arm-linux@gmx.de>
Message-ID: <alpine.LFD.2.00.0910122327280.20122@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Oct 2009, Dieter Kiermaier wrote:

> Hi Simon,
> 
> I've tested you patch against 2.6.32-rc3 from Linus' tree and it works fine and applies without any issues.
> 
> Without patch:
> h-3.2# uname -a
> Linux DB88FXX81 2.6.32-rc3-00256-g36a0790 #1 PREEMPT Fri Oct 9 08:44:33 CEST 2009 armv5tel GNU/Linux
> sh-3.2#
> sh-3.2#
> sh-3.2# lspci
> sh-3.2#
> 
> with applied patch:
> 
> sh-3.2# uname -a
> Linux DB88FXX81 2.6.32-rc3-00256-g36a0790-dirty #2 PREEMPT Fri Oct 9 08:47:02 CEST 2009 armv5tel GNU/Linux
> sh-3.2# lspci
> 00:00.0 Class 0580: Device 11ab:6281 (rev 02)
> 00:01.0 Class 0200: Device 10ec:8168 (rev 01)
> sh-3.2#

I've applied it to the orion repo.

> Sorry for the silly question, but what have I do to ack it?

You basically say so like you did above.  Some maintainers also prefer 
you provide a ready to cop and paste line such as:

Acked-by: Dieter Kiermaier <dk-arm-linux@gmx.de>


Nicolas
