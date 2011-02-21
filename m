From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 21 Feb 2011 22:36:48 +0100
Subject: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
In-Reply-To: <20110221182213.GD15225@atomide.com>
References: <20110217165953.GR20795@atomide.com> <4D5D5770.9020501@ti.com>
	<20110217171747.GC14574@legolas.emea.dhcp.ti.com>
	<4D5D59E5.6020307@ti.com>
	<20110217173711.GF14574@legolas.emea.dhcp.ti.com>
	<4D5D5F13.2010602@ti.com> <20110217181849.GV20795@atomide.com>
	<4D5E7DFF.7020609@ti.com>
	<20110218154135.GF11151@legolas.emea.dhcp.ti.com>
	<4D5EA36A.4000903@ti.com> <20110221182213.GD15225@atomide.com>
Message-ID: <4D62DAF0.9050301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/21/2011 7:22 PM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [110218 08:49]:
>> ---
>>  From b2190f0d339c9d843eb5e370d0db8b7090fbcfab Mon Sep 17 00:00:00 2001
>> From: Benoit Cousson<b-cousson@ti.com>
>> Date: Fri, 18 Feb 2011 14:01:06 +0100
>> Subject: [PATCH] OMAP4: hwmod data: Add rev and dev_attr fields in McSPI
>>
>> - Add a rev attribute to identify various McSPI IP version.
>> - Add a dev_attr structure to provide the number of chipselect
>>    supported by the instance.
> 
> Looks like one seems to be wrapped and does not apply even after unwapping..

#$*%&!@ Thunderbird...

Here is the same one without the "enable word wrap" and attached as well just in case.

It should apply on your omap-for-linus branch at commit df7ffd3.

Regards,
Benoit

---
