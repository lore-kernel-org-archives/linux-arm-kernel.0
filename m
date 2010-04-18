From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Sun, 18 Apr 2010 21:17:19 +0200
Subject: Bug#552270: Marvell CESA driver and Kirkwood
In-Reply-To: <4BCB4009.70707@gmail.com>
References: <4B12F9E7.1020207@gmail.com>
	<20091130211531.GK18101@deprecation.cyrius.com>
	<4B144627.7060901@gmail.com>
	<20091204212847.GC28480@deprecation.cyrius.com>
	<4BCB4009.70707@gmail.com>
Message-ID: <20100418191719.GA2508@Chamillionaire.breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* L.C. | 2010-04-18 19:23:21 [+0200]:

>mv_cesa when enabled on Kirkwood always causes an OOPS whenever
>openswan tries to use the AES module. I'm talking about 2.6.32.
Hmm. I've never tried IPsec. Is it possible to for you test the
cryptodev git tree [0] ? There were a few patches flying by solving an
issue where I did not walk correctly through the scatterlist your
backtrace kinda looks like this could be the issue here.

[0] http://git.kernel.org/?p=linux/kernel/git/herbert/cryptodev-2.6.git;a=summary

Sebastian
