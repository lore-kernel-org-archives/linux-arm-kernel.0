From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 4 Oct 2013 09:53:45 -0400
Subject: Arm PCIe hotplugging
In-Reply-To: <CAFJTrDs=fovP8nWVvH=-a9d_OTbmgQkMLPVeKAc4x6phsuZw9w@mail.gmail.com>
References: <CAFJTrDs=fovP8nWVvH=-a9d_OTbmgQkMLPVeKAc4x6phsuZw9w@mail.gmail.com>
Message-ID: <20131004135345.GA31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matthew,

Please Cc: the relevant maintainers, it helps us pick out emails needing
our attention out of the noise ;-)  I've added them to this reply.

thx,

Jason.

On Fri, Oct 04, 2013 at 02:14:34PM +0100, Matthew Minter wrote:
> Hi again,
> 
> I have been doing some work with an Armada XP board (DB-MV784MP-GP)
> with PCIe support, along with using a PEX 8614 (AA) PCIe switch. The
> switch in question is said to have hot plug support with the PCIe
> downstream slots.
> 
> However using both the generic "pcieport" and the proprietary kernel
> module used by PLX (this took some work to run on an ARM board and is
> very buggy on the platform buggy so the generic in tree drivers are
> preferable) the /sys/bus/pci/slots/ directory is always empty and
> /sys/bus/pci/rescan seems to do nothing.
> 
> Looking closer it seems that in the ARM kernel the PCI hotplug code is
> all disabled. Am I just out of luck and should wait until there is a
> new driver for the PCI switch's hot plug controller and a general hot
> plug framework for ARM or is there some kind of work around?
> 
> Best regards,
> Matthew
> 
> -- 
> 
> 
> ------------------------------
> For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com
> 
> ------------------------------
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
