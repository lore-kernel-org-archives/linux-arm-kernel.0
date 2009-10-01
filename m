From: simon.kagstrom@netinsight.net (Simon Kagstrom)
Date: Thu, 1 Oct 2009 09:04:44 +0200
Subject: kirkwood openrd: random kernel crashes with git kernel
In-Reply-To: <200910010904.18923.dk-arm-linux@gmx.de>
References: <200910010904.18923.dk-arm-linux@gmx.de>
Message-ID: <20091001090444.560b2e0a@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Oct 2009 09:04:18 +0200
Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:

> hm - it seems to be suspect but I've got random kernel crashes with latest openrd git kernel from:
> 
> http://repo.or.cz/w/linux-2.6/linux-2.6-openrd.git
> (BTW: are there any news on bringing the openrd kernel to mainline?)
> 
> It looks like there is something wrong in cpu_idle()???

Try starting with openocd disconnected (i.e., the openocd program
suspended or terminated). I also get random crashes when that is on,
presumably caused by it stopping and resuming the kernel randomly (you
can see that in the openocd terminal window).

// Simon
