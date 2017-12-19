From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 19 Dec 2017 16:14:44 +0530
Subject: [PATCH 0/2] ARM: davinici: move watchdog restart from mach to
 drivers
In-Reply-To: <1513012869-7647-1-git-send-email-david@lechnology.com>
References: <1513012869-7647-1-git-send-email-david@lechnology.com>
Message-ID: <64409d2d-dae3-53ef-67a9-fc4e59d6c9be@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Monday 11 December 2017 10:51 PM, David Lechner wrote:
> This series moves the watchdog restart code from arch/arm/mach-davinci
> to drivers/watchdog.
> 
> Tested working on LEGO MINDSTORMS EV3 (TI AM1808 processor).

The patches look good to me. I also tested them on keystone-k2hk-evm and
da850-lcdk board. Thanks for the much needed clean-up!

Hi Wim,

How do you want to handle this series? Patch 2/2 definitely needs to go
through my tree as it will clash with other code I am queuing.

I can either take 1/2 also through ARM-SoC with your ack (preferred) or
if you give me an immutable commit/tag over v4.15-rc1, I can merge that
to preserve bisect-ability.

Thanks,
Sekhar
