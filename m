From: Thomas.Betker@rohde-schwarz.com (Thomas.Betker at rohde-schwarz.com)
Date: Mon, 18 May 2015 10:31:32 +0200
Subject: [PATCH] ARM: zynq: Set bit 22 in PL310 AuxCtrl register (6395/1)
In-Reply-To: <20150514164048.GF19345@e104818-lin.cambridge.arm.com>
References: <812979c5a158a3306d8036e7f9731947c58a3ab7.1431411716.git.michal.simek@xilinx.com>
 <55519E47.7040008@de.bosch.com>
 <20150514164048.GF19345@e104818-lin.cambridge.arm.com>
Message-ID: <OF7A86E645.4041AF2E-ONC1257E49.002DA5ED-C1257E49.002ED72C@rohde-schwarz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Catalin:

> > I've been under the impression that this shouldn't be done in the 
kernel,
> > but in the boot loader/firmware:
> > 
> > https://lkml.org/lkml/2015/2/20/199
> > 
> > http://lists.denx.de/pipermail/u-boot/2015-March/207803.html
> 
> If you can fix it in the boot loader or firmware even better. If it's
> not doable, this patch will help (if Russell takes it):
> 
> http://article.gmane.org/gmane.linux.ports.sh.devel/45685

Thanks for the info! Geert's patch looks good to me, and I sure hope it 
will be accepted.

Best regards,
Thomas Betker
