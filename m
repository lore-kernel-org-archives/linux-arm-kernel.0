From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 29 Aug 2014 14:39:06 +0200
Subject: CPUIdle Armada 370
In-Reply-To: <1409315625788.95950@vitec.com>
References: <1407333701627.99622@vitec.com>
 <53E24654.6020008@free-electrons.com> <53E249A1.900@free-electrons.com>
 <53E24D2A.50706@free-electrons.com> <1407340917231.68970@vitec.com>
 <53E25369.60809@free-electrons.com> <1407341774154.51157@vitec.com>
 <53E34744.6080300@free-electrons.com> <20140807132132.GD19574@lunn.ch>,
 <53E390D3.7060805@vitec.com> <1409315625788.95950@vitec.com>
Message-ID: <5400746A.6030605@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On 29/08/2014 14:33, Nicolas Derouineau wrote:
> Hello,

> In the end, cpuidle works perfectly fine with the 88F6707 and the
> 88F6W11 model. I guess something was wrong in my configuration
> and/or my build process, but now everything's fine. Thanks for your
> help !

I am happy that it finally works for you and thanks to have kept us
updated.

Gregory

> Nicolas
> ________________________________________
> De : Simon Boulay
> Envoy? : jeudi 7 ao?t 2014 16:44
> ? : Andrew Lunn; Gregory CLEMENT
> Cc : Nicolas Derouineau; Thomas Petazzoni; linux-arm-kernel at lists.infradead.org
> Objet : Re: CPUIdle Armada 370
> 
> Hi,
> 
> On 08/07/2014 03:21 PM, Andrew Lunn wrote:
>>> However I noticed that your base register is 0xf1000000 whereas until now we only
>>> test on platform which have 0xd0000000. Even if the cpu ilde path should not have
>>> any hardcoded value, it could be something to explore.
>>
>> This would imply it is a different version of u-boot. Maybe that could
>> have something to do with it?
> 
> Our u-boot is based on Marvell's BSP 2014_T1.0. It seems that 0xf1000000
> is the default, now.
> For the record we have designed two boards. One is based on the 88F6707
> and the other is based on the 88F6W11 (which is detected as a 88F6710).
> We also have an Armada 370 RD board.
> 
> The plan is that Nicolas will make cpuidle support work on the Armada
> 370 RD first. Then we will try to make it work on our boards.
> 
> Thanks,
> 
> Simon
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
