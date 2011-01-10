From: mail@pawelmoll.com (Pawel Moll)
Date: Mon, 10 Jan 2011 10:10:19 +0000
Subject: [PATCH] mmc, ARM: Add zboot from MMC support for SuperH Mobile ARM
In-Reply-To: <20110109225042.GB29257@verge.net.au>
References: <20110109124928.GC25591@verge.net.au>
	<1294589548.8897.1.camel@rojo> <20110109225042.GB29257@verge.net.au>
Message-ID: <c1e9db480d82d1804930ddcc7bb0db02@rootnode.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 On Mon, 10 Jan 2011 07:50:42 +0900, Simon Horman <horms@verge.net.au> 
 wrote:
>> >  Documentation/arm/SH-Mobile/Makefile              |    8 +
>> >  Documentation/arm/SH-Mobile/vrl4.c                |  169 
>> +++++++++++++++++++++
>> How about putting those two into "tools" (in particular "tools/arm")
>> instead of "Documentation"?
>> Just a thought... ;-)
>
> Thats fine by me except that tools/arm doesn't exist yet.
> It would be good to get some consensus before creating it.

 I think there is consensus regarding "tools" as a place for user-space 
 tools - eg. perf tools used to live in "Documentation/..." and then were 
 moved to "tools/perf".

 Now, whether your stuff should be in "tools/SH-Mobile" or 
 "tools/arm/SH-Mobile", I have no opinion ;-)

 Cheers!

 Pawe?
