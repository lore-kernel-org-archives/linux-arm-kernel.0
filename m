From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 01 Oct 2009 12:15:30 -0400 (EDT)
Subject: kirkwood openrd: random kernel crashes with git kernel
In-Reply-To: <20091001090444.560b2e0a@marrow.netinsight.se>
References: <200910010904.18923.dk-arm-linux@gmx.de>
	<20091001090444.560b2e0a@marrow.netinsight.se>
Message-ID: <alpine.LFD.2.00.0910011214000.4997@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Oct 2009, Simon Kagstrom wrote:

> On Thu, 1 Oct 2009 09:04:18 +0200
> Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:
> 
> > hm - it seems to be suspect but I've got random kernel crashes with latest openrd git kernel from:
> > 
> > http://repo.or.cz/w/linux-2.6/linux-2.6-openrd.git
> > (BTW: are there any news on bringing the openrd kernel to mainline?)
> > 
> > It looks like there is something wrong in cpu_idle()???
> 
> Try starting with openocd disconnected (i.e., the openocd program
> suspended or terminated). I also get random crashes when that is on,
> presumably caused by it stopping and resuming the kernel randomly (you
> can see that in the openocd terminal window).

Also note that openocd cannot work reliably with Linux running on the 
target if you don't use the nohlt kernel cmdline argument.


Nicolas
