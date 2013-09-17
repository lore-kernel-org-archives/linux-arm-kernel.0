From: b32955@freescale.com (Huang Shijie)
Date: Tue, 17 Sep 2013 10:14:25 +0800
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130916110634.GC29403@sirena.org.uk>
References: <1378979431.2627.402.camel@shinybook.infradead.org>
 <20130913025827.GA3051@gmail.com> <1378999322.4210.95.camel@i7.infradead.org>
 <20130913041208.GD3051@gmail.com> <20130912205644.GW29403@sirena.org.uk>
 <52329AD3.2050608@freescale.com> <20130913102127.GD29403@sirena.org.uk>
 <52366F97.5030402@freescale.com> <20130916101912.GY29403@sirena.org.uk>
 <5236DD17.5090203@freescale.com> <20130916110634.GC29403@sirena.org.uk>
Message-ID: <5237BB01.3080700@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?09?16? 19:06, Mark Brown ??:
> I don't know what you mean by "the dummy".
Please see the datasheet of the NOR:
www.spansion.com/Support/Datasheets/S25FL128S_256S_00.pdf


Please see the page 100, the Quad I/O Read, the figure 10.37 shows
the dummy.

The dummy is just a delay in a command sequence.
The dummy maybe only several clock cycles, less then 8 bit.

thanks
Huang Shijie
