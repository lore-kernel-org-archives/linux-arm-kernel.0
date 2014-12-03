From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 3 Dec 2014 16:56:32 +0000 (UTC)
Subject: OMAP baseline test results for v3.18-rc7
In-Reply-To: <547EB63B.5070200@compulab.co.il>
References: <alpine.DEB.2.02.1412021838410.16734@utopia.booyaka.com>
 <547EB63B.5070200@compulab.co.il>
Message-ID: <alpine.DEB.2.02.1412031655140.8865@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Igor,

On Wed, 3 Dec 2014, Igor Grinberg wrote:

> On 12/02/14 20:39, Paul Walmsley wrote:
> > 
> > Here are some basic OMAP test results for Linux v3.18-rc7.
> > Logs and other details at:
> > 
> >     http://www.pwsan.com/omap/testlogs/test_v3.18-rc7/20141201203859/
> 
> [...]
> 
> > Boot to userspace:
> >     FAIL ( 1/16): 2430sdp
> >     skip ( 2/16): 5912osk, 3517evm
> >     Pass (13/16): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
> > 		  4460varsomom, 37xxevm, 3530es3beagle, 3530es31beagle,
> > 		  3730beaglexm, 3730es12beaglexm, 5430es2uevm,
> > 		  5430es2sbct54, 2420n800
> 
> I've looked at the boot log and it seems cm-t3517 is booting just fine...

Thanks for the note.  I will look into this - CM-T3517 should be listed 
there.  

> A problem with the test/report collecting script?

Most likely...

- Paul
