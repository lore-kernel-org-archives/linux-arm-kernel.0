From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 03 Sep 2014 12:12:54 +0300
Subject: OMAP baseline test results for v3.17-rc3
In-Reply-To: <alpine.DEB.2.02.1409022346440.1546@utopia.booyaka.com>
References: <alpine.DEB.2.02.1409022346440.1546@utopia.booyaka.com>
Message-ID: <5406DB96.20904@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 09/03/14 02:52, Paul Walmsley wrote:
> 
> Here are some basic OMAP test results for Linux v3.17-rc3.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.17-rc3/20140902165525/
> 
> 
> Test summary
> ------------

[...]

> Boot to userspace:
>     FAIL ( 2/15): 2430sdp, 5430es2sbct54
>     skip ( 1/15): 5912osk
>     Pass (12/15): 2420n800, 3517evm, 3530es3beagle, 3730beaglexm,
> 		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
> 		  am335xbonelt, cmt3517, 4460varsomom, 5430es2uevm

[...]

> A Compulab SBC-T54 (OMAP5432) has been added to the testbed, graciously 
> donated by Compulab and Igor Grinberg.  It currently isn't booting to 
> userspace in the current mainline kernel, but if the 'ldo8' regulator is 
> modified to be always-on in the omap5-sbc-t54.dts file, it will.

Thanks for the heads up!
Yes, indeed ldo8 powers the serial port transceiver,
led and touch screen controller.
We intend to send fixes in a short while.


-- 
Regards,
Igor.
