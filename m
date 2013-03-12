From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 12 Mar 2013 16:51:50 +0000 (UTC)
Subject: OMAP baseline test results for v3.9-rc1
In-Reply-To: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com>
References: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1303121650090.2723@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Mar 2013, Paul Walmsley wrote:

> Here are some basic OMAP test results for Linux v3.9-rc1.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.9-rc1/20130312100243/

...

> Boot to userspace:
>     FAIL ( 4/11): 2430sdp, 37xxevm, am335xbone, cmt3517
>     Pass ( 7/11): 2420n800, 3517evm, 3530es3beagle,
>   	   	  3730beaglexm, 4430es2panda, 5912osk,
> 		  4460pandaes

It's not correct that 5912osk booted to userspace, given that the kernel 
didn't build.  Looking at the testlogs, it seems to have inadvertently 
booted a 3.8 kernel.  Something else to fix in the scripts.

This has been fixed in the README copy on the web.


- Paul
