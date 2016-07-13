From: diana.craciun@nxp.com (Diana Madalina Craciun)
Date: Wed, 13 Jul 2016 07:57:21 +0000
Subject: [PATCH v9 00/17] KVM: arm64: GICv3 ITS emulation
References: <20160713015909.28793-1-andre.przywara@arm.com>
Message-ID: <HE1PR04MB1321470CDA673EDB88B8930DFF310@HE1PR04MB1321.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On 07/13/2016 04:59 AM, Andre Przywara wrote:
> To test this you can use the kvmtool patches available in the "its-v6"
> branch here [2].
> Start a guest with: "$ lkvm run --irqchip=gicv3-its --force-pci"
> and see the ITS being used for instance by the virtio devices.
>
> [1]: git://linux-arm.org/linux-ap.git
>      http://www.linux-arm.org/git?p=linux-ap.git;a=log;h=refs/heads/its-emul/v9
> [2]: git://linux-arm.org/kvmtool.git

It seems that its/emul/v9 branch does not exist.

Thanks,

Diana
