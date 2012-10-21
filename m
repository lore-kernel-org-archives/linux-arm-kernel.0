From: richardcochran@gmail.com (Richard Cochran)
Date: Sun, 21 Oct 2012 13:44:46 +0200
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <alpine.DEB.2.00.1210210804060.10693@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <20121020141136.GA6433@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210201615170.24497@utopia.booyaka.com>
 <20121021073551.GA4735@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210210804060.10693@utopia.booyaka.com>
Message-ID: <20121021114446.GC6756@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 21, 2012 at 08:23:35AM +0000, Paul Walmsley wrote:
> On Sun, 21 Oct 2012, Richard Cochran wrote:
>
> > When I read your report, it gave me a much rosier picture than is 
> > actually the case WRT the beaglebone.
> 
> Really?  What section of the message provided that to you?

It was the part that said,

   Passing tests
   -------------
   
   Boot to userspace: 3517evm, 3530es3beagle, 3730beaglexm, 37xxevm,
                      4430es2panda, 5912osk, am335xbone

It sounded to me like you were saying that the current kernel release
boots just fine on the beaglebone, with no issues.

It surprised me, because in fact I have had one heck of a time getting
the beaglebone to boot. It is a bit of a cop-out to say that you are
not interested in the boot loader. Way back when the whole "dt is so
cool, arm should use it too" argument appeared, I wrote that, in my
experience with Freescale powerpc chips, the whole kernel/dt/u-boot is
a kind of Bermuda Triangle of misfortune. Looks like that dt is
turning out to be just as successful for arm as it was for powerpc.

Thanks,
Richard
