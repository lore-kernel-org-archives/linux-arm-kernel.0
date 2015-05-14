From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 14 May 2015 17:40:49 +0100
Subject: [PATCH] ARM: zynq: Set bit 22 in PL310 AuxCtrl register (6395/1)
In-Reply-To: <55519E47.7040008@de.bosch.com>
References: <812979c5a158a3306d8036e7f9731947c58a3ab7.1431411716.git.michal.simek@xilinx.com>
 <55519E47.7040008@de.bosch.com>
Message-ID: <20150514164048.GF19345@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 08:31:35AM +0200, Dirk Behme wrote:
> On 12.05.2015 08:22, Michal Simek wrote:
> >From: Thomas Betker <thomas.betker@rohde-schwarz.com>
> >
> >This patch is based on the
> >commit 1a8e41cd672f ("ARM: 6395/1: VExpress: Set bit 22 in the PL310
> >(cache controller) AuxCtlr register")
> 
> I've been under the impression that this shouldn't be done in the kernel,
> but in the boot loader/firmware:
> 
> https://lkml.org/lkml/2015/2/20/199
> 
> http://lists.denx.de/pipermail/u-boot/2015-March/207803.html

If you can fix it in the boot loader or firmware even better. If it's
not doable, this patch will help (if Russell takes it):

http://article.gmane.org/gmane.linux.ports.sh.devel/45685

-- 
Catalin
