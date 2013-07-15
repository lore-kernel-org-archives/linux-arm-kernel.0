From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 15 Jul 2013 21:51:43 +0200
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <51E41944.6030403@keymile.com>
References: <51DD88A4.1030506@keymile.com> <20130710185706.72b124a4@skate>
 <51DD9A8C.10608@keymile.com> <51DE58DF.5010304@keymile.com>
 <20130712105903.6336e912@skate> <51E41944.6030403@keymile.com>
Message-ID: <20130715215143.5167a987@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Valentin Longchamp,

On Mon, 15 Jul 2013 17:46:12 +0200, Valentin Longchamp wrote:

> > I'm not sure to follow this story of a virtual PCIe controller sitting
> > at 0xf4000000. Can you give a few more details?
> > 
> 
> I'm not sure I can give all the details here as the documentation that we have
> for this is subject to an NDA. To keep it short, in the kirkwood SoC we use,
> there is an Ethernet Switch that is accessed by the kirkwood through an internal
> virtual PCIe controller. The switch management SW has some hard expectations
> about the physical address for this "PCIe" memory mapped window which conflicts
> with the ones defined in the current device trees.

Ok. Note that the addresses chosen in the Device Tree can easily be
changed on a per-SoC or per-board basis, if needed.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
