From: simon.boulay@vitec.com (Simon Boulay)
Date: Thu, 7 Aug 2014 16:44:35 +0200
Subject: CPUIdle Armada 370
In-Reply-To: <20140807132132.GD19574@lunn.ch>
References: <1407333701627.99622@vitec.com>
 <53E24654.6020008@free-electrons.com> <53E249A1.900@free-electrons.com>
 <53E24D2A.50706@free-electrons.com> <1407340917231.68970@vitec.com>
 <53E25369.60809@free-electrons.com> <1407341774154.51157@vitec.com>
 <53E34744.6080300@free-electrons.com> <20140807132132.GD19574@lunn.ch>
Message-ID: <53E390D3.7060805@vitec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/07/2014 03:21 PM, Andrew Lunn wrote:
>> However I noticed that your base register is 0xf1000000 whereas until now we only
>> test on platform which have 0xd0000000. Even if the cpu ilde path should not have
>> any hardcoded value, it could be something to explore.
>
> This would imply it is a different version of u-boot. Maybe that could
> have something to do with it?

Our u-boot is based on Marvell's BSP 2014_T1.0. It seems that 0xf1000000 
is the default, now.
For the record we have designed two boards. One is based on the 88F6707 
and the other is based on the 88F6W11 (which is detected as a 88F6710).
We also have an Armada 370 RD board.

The plan is that Nicolas will make cpuidle support work on the Armada 
370 RD first. Then we will try to make it work on our boards.

Thanks,

Simon
