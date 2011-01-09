From: horms@verge.net.au (Simon Horman)
Date: Mon, 10 Jan 2011 07:50:42 +0900
Subject: [PATCH] mmc, ARM: Add zboot from MMC support for SuperH Mobile ARM
In-Reply-To: <1294589548.8897.1.camel@rojo>
References: <20110109124928.GC25591@verge.net.au>
	<1294589548.8897.1.camel@rojo>
Message-ID: <20110109225042.GB29257@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 09, 2011 at 04:12:28PM +0000, Pawe? Moll wrote:
> Hi,
> 
> >  Documentation/arm/SH-Mobile/Makefile              |    8 +
> >  Documentation/arm/SH-Mobile/vrl4.c                |  169 +++++++++++++++++++++
> 
> How about putting those two into "tools" (in particular "tools/arm")
> instead of "Documentation"?
> 
> Just a thought... ;-)

Thats fine by me except that tools/arm doesn't exist yet.
It would be good to get some consensus before creating it.
