From: will.deacon@arm.com (Will Deacon)
Date: Fri, 5 Sep 2014 09:42:54 +0100
Subject: [PATCH v2 0/4] arm64, thunder: Enable Cavium Thunder SoC Family
In-Reply-To: <1409903205-2762-1-git-send-email-rric@kernel.org>
References: <1409903205-2762-1-git-send-email-rric@kernel.org>
Message-ID: <20140905084254.GF13515@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 08:46:41AM +0100, Robert Richter wrote:
> From: Robert Richter <rrichter@cavium.com>
> 
> This initial patches enable Cavium Thunder SoC Family. The patches add
> Kconfig and devicetree support and then add Thunder to the defconfig.
> 
> The Thunder system needs more enablement patches for subsystems and
> devices, this includes network, ahci, gicv3/gicv3-its, pci, smmu, kvm.
> We will send separate patch sets for these. All of them base on this
> initial patches.
> 
> I sent a separate patch set independently that introduces support for
> dts vendor subdirs. After both patch sets have been applied I will
> send a patch in addition that moves the dts file into a subdirectory.
> 
> Patches are available here:

If you can get some acks for the DT bits, I'm happy to take this via the
arm64 tree for 3.18.

Will
