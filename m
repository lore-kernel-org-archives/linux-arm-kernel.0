From: tony@atomide.com (Tony Lindgren)
Date: Mon, 29 Sep 2014 10:20:50 -0700
Subject: OMAP baseline test results for v3.17-rc7
In-Reply-To: <alpine.DEB.2.02.1409291709020.7233@utopia.booyaka.com>
References: <alpine.DEB.2.02.1409291709020.7233@utopia.booyaka.com>
Message-ID: <20140929172049.GD3122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [140929 10:14]:
>
> PM: chip off except CORE via suspend:
>     Pass ( 1/ 1): 3730beaglexm
> 
> PM: chip off except CORE via dynamic idle:
>     Pass ( 1/ 1): 3730beaglexm

Most likely the two tests above should now also work also for 37xxevm,
3530es3beagle and 3530es31beagle in case you want to enable that.
 
> PM: chip off via suspend:
>     Pass ( 4/ 4): 37xxevm, 3530es3beagle, 3530es31beagle,
> 		  3730es12beaglexm
> 
> PM: chip off via dynamic idle:
>     Pass ( 4/ 4): 37xxevm, 3530es3beagle, 3530es31beagle,
> 		  3730es12beaglexm

Since looks like these are working finally :)

Regards,

Tony
