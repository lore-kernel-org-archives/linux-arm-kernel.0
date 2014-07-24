From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 24 Jul 2014 08:00:34 -0400
Subject: [PATCHv3 11/16] cpuidle: mvebu: rename the driver from
 armada-370-xp to mvebu-v7
In-Reply-To: <53D0CEA3.1050204@linaro.org>
References: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1406120453-29291-12-git-send-email-thomas.petazzoni@free-electrons.com>
 <53D0CEA3.1050204@linaro.org>
Message-ID: <20140724120034.GS23220@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 11:15:15AM +0200, Daniel Lezcano wrote:
> On 07/23/2014 03:00 PM, Thomas Petazzoni wrote:
> >From: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >
> >This driver will be able to manage the cpuidle for more SoCs than just
> >Armada 370 and XP. It will also support Armada 38x and potentially
> >other SoC of the Marvell Armada EBU family. To take this into account,
> >this patch renames the driver and its symbols.
> >
> >It also changes the driver name from cpuidle-armada-370-xp to
> >cpuidle-armada-xp, because separate platform drivers will be
> >registered for the other SoC types. This change must be done
> >simultaneously in the cpuidle driver and in the PMSU code in order to
> >remain bisectable.
> >
> >Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks for getting on top of this so quickly after returning from
vacation!

thx,

Jason.
