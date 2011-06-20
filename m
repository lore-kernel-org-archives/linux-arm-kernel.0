From: johnlinn@comcast.net (johnlinn at comcast.net)
Date: Mon, 20 Jun 2011 17:33:06 +0000 (UTC)
Subject: Pull request for Xilinx Zynq platform support
In-Reply-To: <BANLkTi=OcRgtg-WtZfzNkd4n6EkKpf=m9A@mail.gmail.com>
Message-ID: <596894907.105804.1308591186352.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Mon, Jun 20, 2011 at 11:28 AM, <johnlinn@comcast.net> wrote:
> > Hi Arnd,
> >
> > Please pull this commit to support the Xilinx Zynq platform into
> > your tree.
> >
> > This patch has been out in the community and mailing list for a
> > while. ?It has
> > also been in linux-next for a while.
> >
> > Thanks,
> > John Linn
> >
> > The following changes since commit
> > 2c53b436a30867eb6b47dd7bab23ba638d1fb0d2:
> > ?Linus Torvalds (1):
> > ? ? ? ?Linux 3.0-rc3
> >
> > are available in the git repository at:
> >
> > ?git://git.xilinx.com/arm-next
> >
> > Grant Likely (1):
> > ? ? ?ARM: Xilinx: Adding Xilinx board support
> 
> Oops, this isn't right. You should respin the branch to credit you as
> the author. All I did was squash a bunch of patches together.
> 
> g.

Ok, I'll respin the patch to remove that and send out the pull request again.

Thanks,
John

> 
> >
> > ?Documentation/devicetree/bindings/arm/xilinx.txt | ? ?7 +
> > ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? 14 +
> > ?arch/arm/Makefile ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?2 +
> > ?arch/arm/boot/dts/zynq-ep107.dts ? ? ? ? ? ? ? ? | ? 52 ++++
> > ?arch/arm/mach-zynq/Makefile ? ? ? ? ? ? ? ? ? ? ?| ? ?6 +
> > ?arch/arm/mach-zynq/Makefile.boot ? ? ? ? ? ? ? ? | ? ?3 +
> > ?arch/arm/mach-zynq/board_dt.c ? ? ? ? ? ? ? ? ? ?| ? 37 +++
> > ?arch/arm/mach-zynq/common.c ? ? ? ? ? ? ? ? ? ? ?| ?102 ++++++++
> > ?arch/arm/mach-zynq/common.h ? ? ? ? ? ? ? ? ? ? ?| ? 29 ++
> > ?arch/arm/mach-zynq/include/mach/clkdev.h ? ? ? ? | ? 32 +++
> > ?arch/arm/mach-zynq/include/mach/debug-macro.S ? ?| ? 36 +++
> > ?arch/arm/mach-zynq/include/mach/entry-macro.S ? ?| ? 30 +++
> > ?arch/arm/mach-zynq/include/mach/hardware.h ? ? ? | ? 18 ++
> > ?arch/arm/mach-zynq/include/mach/io.h ? ? ? ? ? ? | ? 33 +++
> > ?arch/arm/mach-zynq/include/mach/irqs.h ? ? ? ? ? | ? 21 ++
> > ?arch/arm/mach-zynq/include/mach/memory.h ? ? ? ? | ? 22 ++
> > ?arch/arm/mach-zynq/include/mach/system.h ? ? ? ? | ? 28 ++
> > ?arch/arm/mach-zynq/include/mach/timex.h ? ? ? ? ?| ? 23 ++
> > ?arch/arm/mach-zynq/include/mach/uart.h ? ? ? ? ? | ? 25 ++
> > ?arch/arm/mach-zynq/include/mach/uncompress.h ? ? | ? 51 ++++
> > ?arch/arm/mach-zynq/include/mach/vmalloc.h ? ? ? ?| ? 20 ++
> > ?arch/arm/mach-zynq/include/mach/zynq_soc.h ? ? ? | ? 48 ++++
> > ?arch/arm/mach-zynq/timer.c ? ? ? ? ? ? ? ? ? ? ? | ?298
> > ++++++++++++++++++++++
> > ?arch/arm/mm/Kconfig
> >
> 
> 
> 
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
