From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 1 Nov 2012 17:14:26 +0100
Subject: [PATCH 0/3] ARM: dts: OMAP4/5 device-tree timer updates
In-Reply-To: <1351784967-32520-1-git-send-email-jon-hunter@ti.com>
References: <1351784967-32520-1-git-send-email-jon-hunter@ti.com>
Message-ID: <50929FE2.9090602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On 11/01/2012 04:49 PM, Jon Hunter wrote:
> A few device tree timer updates for OMAP4/5 devices.
> 
> This series adds ...
> 1. MPU private addresses for OMAP4 timers
> 2. Timer nodes for OMAP5
> 3. 32kHz counter node for OMAP5

Great, thanks for that update. Just in time before the pull request.

> This is based upon of Benoit Cousson's OMAP device-tree branch for v3.8.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.8/dts
> 
> Jon Hunter (3):
>   ARM: dts: Update OMAP4 timer addresses
>   ARM: dts: Add OMAP5 timer nodes
>   ARM: dts: Add OMAP5 counter node

I've just updated slightly the subjects:

3b3132f ARM: dts: OMAP5: Add counter node
df692a9 ARM: dts: OMAP5: Add timer nodes
d03a93b ARM: dts: OMAP4: Update timer addresses

There are now in my for_3.8/dts branch.

Thanks,
Benoit
