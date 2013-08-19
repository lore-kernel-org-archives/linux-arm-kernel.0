From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 19 Aug 2013 16:04:17 +0530
Subject: [PATCH 1/2] Documentation: devicetree: arm: cpus/cpu nodes
 bindings updates
In-Reply-To: <20130815152238.GF17839@e102568-lin.cambridge.arm.com>
References: <1376559743-31848-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1376559743-31848-2-git-send-email-lorenzo.pieralisi@arm.com>
 <520CE665.8060907@gmail.com>
 <20130815152238.GF17839@e102568-lin.cambridge.arm.com>
Message-ID: <5211F4A9.4090805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Thursday 15 August 2013 08:52 PM, Lorenzo Pieralisi wrote:

> On a side note I have just noticed that last cycle some dts were merged in the
> kernel with cpu nodes that are not compliant (not picking on anyone,

> eg am4372.dtsi).

mea culpa

am4372.dtsi was posted early in last cycle and started it's journey
towards mainline after quite sometime. iirc, am4372 was posted around
the time cpu node update was on the lists.

The relevant silicon is in pre-silicon stage, I was going back & forth
on whether patches to fix it should go in -rc's or the coming merge
window, finally settled for next merge window as am43x won't boot on
mainline with last Kernel version.

The patches to fix cpu nodes in am4372 has been posted, acked by Mark
Rutland, hopefully would make into mainline this merge window.

Regards
Afzal
