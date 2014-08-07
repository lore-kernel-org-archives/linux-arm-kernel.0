From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 7 Aug 2014 15:21:32 +0200
Subject: CPUIdle Armada 370
In-Reply-To: <53E34744.6080300@free-electrons.com>
References: <1407333701627.99622@vitec.com>
 <53E24654.6020008@free-electrons.com>
 <53E249A1.900@free-electrons.com>
 <53E24D2A.50706@free-electrons.com> <1407340917231.68970@vitec.com>
 <53E25369.60809@free-electrons.com> <1407341774154.51157@vitec.com>
 <53E34744.6080300@free-electrons.com>
Message-ID: <20140807132132.GD19574@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory

> However I noticed that your base register is 0xf1000000 whereas until now we only
> test on platform which have 0xd0000000. Even if the cpu ilde path should not have
> any hardcoded value, it could be something to explore.

This would imply it is a different version of u-boot. Maybe that could
have something to do with it?

     Andrew
