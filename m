From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 May 2013 14:13:29 -0700
Subject: OMAP baseline test results for v3.9
In-Reply-To: <alpine.DEB.2.00.1305081933270.19747@utopia.booyaka.com>
References: <alpine.DEB.2.00.1305081933270.19747@utopia.booyaka.com>
Message-ID: <20130514211328.GC5600@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Paul Walmsley <paul@pwsan.com> [130508 12:45]:
> 
> PM off, dynamic idle:
>     FAIL ( 2/ 5): 4430es2panda, 4460pandaes
>     Pass ( 3/ 5): 3530es3beagle, 3730beaglexm, 37xxevm

Looking at your pm logs, 3730beaglexm won't hit off-idle.
I've pasted the relevant lines from your logs below.

Is this a known issue?

Regards,

Tony


3530es3beagle hits OFF:
core_pwrdm (ON),OFF:24,RET:41,INA:0,ON:66,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0

3730beaglexm won't hit OFF:
core_pwrdm (ON),OFF:0,RET:88,INA:0,ON:89,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0

37xxevm hits OFF:
core_pwrdm (ON),OFF:8,RET:10,INA:0,ON:19,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
