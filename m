From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 12 Sep 2018 11:08:48 -0500
Subject: [PATCH] gpio: omap: Add level wakeup handling for omap4 based SoCs
In-Reply-To: <20180912004252.GH5662@atomide.com>
References: <20180910200624.4494-1-tony@atomide.com>
 <444bae18-9737-8e13-2a0f-c08863ae1336@ti.com>
 <20180911182419.GC5662@atomide.com>
 <a10ae1a9-ed6a-468e-5a3e-8c120bab9acf@ti.com>
 <20180912004252.GH5662@atomide.com>
Message-ID: <2cfe2f9d-a465-0568-bf48-8dcde535ff99@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/11/2018 07:42 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [180912 00:27]:
>> Thanks Tony, but it's still not completely clear -
>> it's important to see values of CLKSTCTRL before/after idle for not working
>> case and GPIO SYSC/SYSS registers. There are some combinations which may
>> affect on this. So, if you can, pls.
> 
> Sure I'll do some reg dumps for you tomorrow as I just started
> an overnight test with randomly pinging the wlan interface
> from outside to make sure it wakes up and keeps idling.

Pls, postpone this until we finish our discussion/debugging


-- 
regards,
-grygorii
