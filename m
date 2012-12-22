From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 22 Dec 2012 15:50:40 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121220153231.GA11256@avionic-0098.adnet.avionic-design.de>
References: <50CA1A8D.9070504@wwwdotorg.org>
 <20121213204229.GC18597@avionic-0098.adnet.avionic-design.de>
 <20121214151045.GA22304@avionic-0098.adnet.avionic-design.de>
 <20121214172729.GA7671@obsidianresearch.com>
 <20121216123340.GB31780@avionic-0098.adnet.avionic-design.de>
 <20121217182911.GA10448@obsidianresearch.com>
 <20121217194147.GA2767@avionic-0098.adnet.avionic-design.de>
 <50CFD0B3.6030208@wwwdotorg.org>
 <20121218025113.GA27029@obsidianresearch.com>
 <50D0A1EA.9090009@wwwdotorg.org>
 <20121220153231.GA11256@avionic-0098.adnet.avionic-design.de>
Message-ID: <20121222155040.61829b00@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Thierry Reding,

On Thu, 20 Dec 2012 16:32:31 +0100, Thierry Reding wrote:

> The complete code can be found in my tegra/next branch[0]. Beware that I
> haven't cleaned up that branch in a while, so anything but looking at
> the end result is not very recommended =). The branch contains patches
> (untested) to make Harmony and TrimSlice initialize the PCIe from the
> device tree, so anyone inclined to give this a spin should be able to do
> so. If you want to try out the software emulated host bridge, you can
> just uncomment the "#define EMULATE_HOST_BRIDGE 1" at the top of
> arch/arm/mach-tegra/pcie.c.

Thanks for putting your code online. I've started using it already for
the Marvell PCIe support, at least the host-bridge.c helpers you've
written, and also to have a look at the DT binding you've implemented.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121222/89f751ac/attachment.sig>
