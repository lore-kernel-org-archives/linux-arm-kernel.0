From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 5 Apr 2013 17:32:18 -0400 (EDT)
Subject: [GIT PULL] Multi Cluster Power Management infrastructure
In-Reply-To: <CAOesGMiN1oEMTjVVOiXs2ynccnvTgFgn=Fy1wGHhsGqL0XUATQ@mail.gmail.com>
References: <alpine.LFD.2.03.1303251219530.1372@syhkavp.arg>
 <alpine.LFD.2.03.1304042138160.1171@syhkavp.arg>
 <20130405094159.GH17995@n2100.arm.linux.org.uk>
 <201304052233.25630.arnd@arndb.de>
 <CAOesGMiN1oEMTjVVOiXs2ynccnvTgFgn=Fy1wGHhsGqL0XUATQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1304051722330.1171@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Apr 2013, Olof Johansson wrote:

> Can someone please provide a link or subject for the posted patch
> series for the dependent platform code? I tried to search for it on
> the lists but didn't have much luck.

As mentioned in my cover letter, the dependent platform code for RTSM 
has been publicly posted along with the MCPM patches in all 4 review 
cycles.  Those patches therefore were reviewed all together.  The plan 
was to have the MCPM into mainline during the previous merge window via 
Russell, and the platform code via ARM SoC either during the previous 
cycle time permitting, or this cycle otherwise.

Therefore the MCPM pull request includes only the MCPM patches.  Another 
pull request for the remaining patches is still pending for ARM SoC.

If you want to see all patches together, you may have a look at the 
following branch:

  git://git.linaro.org/people/nico/linux mcpm+dcscb

> I think platform code should wait until 3.11 instead of getting
> crammed in at post-rc6. If it hasn't already been posted by now, it
> should most definitely wait. That also saves on any contentious
> dependency between the two.

It was posted *tree* months ago.  It was reviewed *four* times already.


Nicolas
