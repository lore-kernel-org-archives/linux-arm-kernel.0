From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 3 Mar 2016 15:57:10 +0100
Subject: [PATCH 03/17] dt-bindings: Add PLX Technology RPS IRQ Controller
 bindings
In-Reply-To: <20160303145348.GI15541@lunn.ch>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457005210-18485-4-git-send-email-narmstrong@baylibre.com>
 <20160303145348.GI15541@lunn.ch>
Message-ID: <56D850C6.1010404@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 03/03/2016 03:53 PM, Andrew Lunn wrote:
> 
>> +- compatible: Should be "plxtech,nas782x-rps"
> 
> Hi Neil
> 
> It would be nice to be consistent with the naming.
The compatible is now oxsemi,os810se-rps-irq which is consistent with the timer.

> 
> Maybe also the filename of the driver itself should be changed. You
> had an interesting sorting problem in the Makefile, which a consistent
> name would help with.
Yes, I will add -irq to the driver name and _IRQ to the config name.

> 
>      Andrew
> 
Thanks,
Neil
