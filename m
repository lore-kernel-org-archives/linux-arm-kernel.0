From: tony@atomide.com (Tony Lindgren)
Date: Thu, 31 Jul 2014 06:11:08 -0700
Subject: OMAP baseline test results for v3.16-rc4
In-Reply-To: <alpine.DEB.2.02.1407300725290.4477@utopia.booyaka.com>
References: <alpine.DEB.2.02.1407251857480.5875@utopia.booyaka.com>
 <20140729064243.GF29045@atomide.com>
 <alpine.DEB.2.02.1407290810160.22957@utopia.booyaka.com>
 <20140729084930.GH29045@atomide.com>
 <alpine.DEB.2.02.1407291225070.13035@utopia.booyaka.com>
 <alpine.DEB.2.02.1407291256270.13035@utopia.booyaka.com>
 <20140729145312.GT29045@atomide.com>
 <alpine.DEB.2.02.1407291922370.13035@utopia.booyaka.com>
 <20140730053940.GX29045@atomide.com>
 <alpine.DEB.2.02.1407300725290.4477@utopia.booyaka.com>
Message-ID: <20140731131107.GB29045@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [140730 00:55]:
> On Tue, 29 Jul 2014, Tony Lindgren wrote:
> 
> > The following patch should fix the tests above for 3530es3beagle.
> > Care to test and ack as I don't have one?
> 
> 3530es3beagle retention dynamic idle tests hang on next-20140729.  (Maybe 
> other boards fail too - haven't tested any others).  

I just checked that today's linux next works for off-idle and
wake-up events for at least 37xx evm.
 
> http://www.pwsan.com/omap/testlogs/next_20140729/20140730010841/pm/3530es3beagle/3530es3beagle_log.txt
> 
> Adding the patch you sent doesn't change that, but now some extra warning 
> messages appear ("PRM: I/O chain clock line assertion timed out"):
> 
> http://www.pwsan.com/omap/testlogs/next_20140729_beagle_pm/20140730004856/pm/3530es3beagle/3530es3beagle_log.txt

Weird it should just work. I don't know why the "PRM: I/O chain
clock line assertion timed out" happens for you, I have not seen
that. So far I've tested it on n900, beagle xm and 37xx-evm. None
of those are 3530 though, but it should behave the same way as
on n900.

Regards,

Tony
