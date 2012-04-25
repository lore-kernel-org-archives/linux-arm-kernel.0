From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 25 Apr 2012 17:22:57 +0200
Subject: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree data
In-Reply-To: <alpine.DEB.2.00.1204250755020.29696@utopia.booyaka.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
 <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204241857260.24864@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9FD175@DBDE01.ent.ti.com>
 <4F97B891.1020601@ti.com>
 <79CD15C6BA57404B839C016229A409A83E9FD707@DBDE01.ent.ti.com>
 <4F97E243.6000500@ti.com>
 <79CD15C6BA57404B839C016229A409A83E9FDA47@DBDE01.ent.ti.com>
 <4F97EF11.4020300@ti.com>
 <79CD15C6BA57404B839C016229A409A83E9FDAE7@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204250755020.29696@utopia.booyaka.com>
Message-ID: <4F9816D1.3000102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/25/2012 3:55 PM, Paul Walmsley wrote:
> Hi Vaibhav,
>
> On Wed, 25 Apr 2012, Hiremath, Vaibhav wrote:
>
>> Thanks for describing it for me. I will change AM33XX clock tree for this
>> And submit the next version soon.
>
> Well I can just remove those leaf clock entries from my copy here, if
> you're okay with that ?

Please take care of changing the hwmod main_clk as well. But maybe 
that's not part of that series.
