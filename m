From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 30 May 2013 00:00:36 +0200
Subject: [PATCH] arm: kirkwood: convert NETGEAR ReadyNAS Duo v2 to use DT
 for the PCIe interface
In-Reply-To: <20130529114846.GQ31290@titan.lakedaemon.net> (Jason Cooper's
 message of "Wed, 29 May 2013 07:48:46 -0400")
References: <8738t6ycnm.fsf@natisbad.org>
 <20130529114846.GQ31290@titan.lakedaemon.net>
Message-ID: <87li6xla4b.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

Jason Cooper <jason@lakedaemon.net> writes:

>>  arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts |    8 ++++++++
>>  arch/arm/mach-kirkwood/board-readynas.c                |    1 -
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> Hey, I had a little time to kill, so I went ahead and fixed this up.
> Let me know if this looks ok.  I've applied it to mvebu/pcie_kirkwood,
> so you should just be able to pull that and test it.  I'll push it up to
> arm-soc in a week or so.

Pulled the branch, compiled and tested it: USB 3.0 host controller
connected to PCIe bus works as expected.

Thanks for your work,

Cheers,

a+
