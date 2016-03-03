From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 3 Mar 2016 04:05:44 +0200
Subject: [GIT PULL] NXP LPC32xx Platform Updates for v4.6 #1
In-Reply-To: <11608683.muXZLfFRbg@wuerfel>
References: <56BBE6E6.4080802@mleia.com> <20160224213633.GF10126@localhost>
 <56D76FAB.9090908@mleia.com> <11608683.muXZLfFRbg@wuerfel>
Message-ID: <56D79BF8.1030508@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 03.03.2016 01:27, Arnd Bergmann wrote:
> On Thursday 03 March 2016 00:56:43 Vladimir Zapolskiy wrote:
>> I would really appreciate, if this pull request is accepted for v4.6, if it
>> happens then most probably v4.7 will contain all needed irqchip fixes --
>> this pull request removes a duplicated timer driver, which in turn strictly
>> depends on a legacy platform clock driver (removed) and on hardware irq
>> numbering provided by a legacy irqchip driver (will be removed in v4.7
>> hopefully).
> 
> As far as I can tell, Olof merged the series into the next/cleanup
> branch on Feb 24, but did not make that clear enough in his reply.
> 
> I don't see anything holding up your patches from going into 4.6,
> everything should be fine, let me know if there are any other
> problems here, and please check if the arm-soc/for-next branch
> works for you.
> 

I've checked it and everything is fine, thank you for pointing it out.

--
With best wishes,
Vladimir
