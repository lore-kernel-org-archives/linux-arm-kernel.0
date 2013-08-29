From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Aug 2013 16:36:47 -0700
Subject: [PATCH v3 5/5] ARM: bcm4760: Add restart hook
In-Reply-To: <20130814221238.291003843@gmail.com>
References: <20130814221043.528864175@gmail.com>
 <20130814221238.291003843@gmail.com>
Message-ID: <20130829233647.GC29606@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 15, 2013 at 12:10:48AM +0200, Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> Restart hook implementation for the Broadcom BCM4760 based ARM11 SoCs.

This essentially implements a wdt driver under mach-bcm. It'd be better
to contain this under drivers/watchdog and use the reboot notifier to
do the restart from there.


-Olof
