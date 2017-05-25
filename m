From: tony@atomide.com (Tony Lindgren)
Date: Thu, 25 May 2017 15:13:33 -0700
Subject: [CFT] Always enable SMP mode on MP capable CPUs
In-Reply-To: <20170525180540.GW23750@n2100.armlinux.org.uk>
References: <20170518105209.GN22219@n2100.armlinux.org.uk>
 <CAOMZO5Da2R2_t2nU+MdrJiSzvcBQKS4pwYS96r4UyfGc8DtWww@mail.gmail.com>
 <CAOMZO5Dc=i7UdQH=r5RRr_4GmyZZT+rh7BTNV4WbfqKvtVDfsw@mail.gmail.com>
 <20170519171526.GW22219@n2100.armlinux.org.uk>
 <20170524153847.GY10472@atomide.com>
 <20170525144800.GV23750@n2100.armlinux.org.uk>
 <20170525151103.GC10472@atomide.com>
 <20170525180540.GW23750@n2100.armlinux.org.uk>
Message-ID: <20170525221332.GE10472@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [170525 11:09]:
> On Thu, May 25, 2017 at 08:11:03AM -0700, Tony Lindgren wrote:
> > 
> > OK. That may not work on am437x though as it's UP.
> 
> Maybe this is just too complicated to grasp - in which case just test
> tonight's linux-next on *all* your boards irrespective of the CPU, and
> let me know if there's a regression due to this patch, giving me full
> details of your CPUs (CPU ID numbers, number of CPUs, etc.)  If no one
> reports a regression that doesn't get fixed, I'll merge it during the
> next merge window.

OK so got my am437x-idk back up and running again. I'm kind of
running out of space here..

And as suspected it won't boot with these changes. It's a UP core:

CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
OF: fdt: Machine model: TI AM437x Industrial Development Kit

Regards,

Tony
