From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 21 May 2013 10:46:51 -0700
Subject: OMAP baseline test results for v3.10-rc1
In-Reply-To: <alpine.DEB.2.00.1305192219240.2656@utopia.booyaka.com> (Paul
 Walmsley's message of "Sun, 19 May 2013 22:29:40 +0000 (UTC)")
References: <alpine.DEB.2.00.1305192159080.2656@utopia.booyaka.com>
 <alpine.DEB.2.00.1305192219240.2656@utopia.booyaka.com>
Message-ID: <874ndwmdis.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

[...]

> PM: chip retention via suspend:
>     FAIL ( 4/ 6): 2430sdp, 37xxevm, 4430es2panda, 4460pandaes
>     Pass ( 2/ 6): 3530es3beagle, 3730beaglexm

FYI...

I also just noticed that 3730beaglexm has stopped waking from suspend
via RTC (non-DT boot.)  Waking from UART console still works.

Worked fine on v3.9, so there's a regressions somewhere.

Kevin
