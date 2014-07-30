From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 30 Jul 2014 07:53:08 +0000 (UTC)
Subject: OMAP baseline test results for v3.16-rc4
In-Reply-To: <20140730053940.GX29045@atomide.com>
References: <alpine.DEB.2.02.1407062339420.15016@utopia.booyaka.com>
 <20140707080238.GF28884@atomide.com>
 <alpine.DEB.2.02.1407251857480.5875@utopia.booyaka.com>
 <20140729064243.GF29045@atomide.com>
 <alpine.DEB.2.02.1407290810160.22957@utopia.booyaka.com>
 <20140729084930.GH29045@atomide.com>
 <alpine.DEB.2.02.1407291225070.13035@utopia.booyaka.com>
 <alpine.DEB.2.02.1407291256270.13035@utopia.booyaka.com>
 <20140729145312.GT29045@atomide.com>
 <alpine.DEB.2.02.1407291922370.13035@utopia.booyaka.com>
 <20140730053940.GX29045@atomide.com>
Message-ID: <alpine.DEB.2.02.1407300725290.4477@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Jul 2014, Tony Lindgren wrote:

> The following patch should fix the tests above for 3530es3beagle.
> Care to test and ack as I don't have one?

3530es3beagle retention dynamic idle tests hang on next-20140729.  (Maybe 
other boards fail too - haven't tested any others).  

http://www.pwsan.com/omap/testlogs/next_20140729/20140730010841/pm/3530es3beagle/3530es3beagle_log.txt

Adding the patch you sent doesn't change that, but now some extra warning 
messages appear ("PRM: I/O chain clock line assertion timed out"):

http://www.pwsan.com/omap/testlogs/next_20140729_beagle_pm/20140730004856/pm/3530es3beagle/3530es3beagle_log.txt


- Paul
