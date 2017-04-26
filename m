From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 26 Apr 2017 20:53:48 +0200
Subject: [RFC/RFT PATCH 07/18] ARM: PCI: orion5x: Convert PCI scan API to
 pci_scan_root_bus_bridge()
In-Reply-To: <20170426161335.GA12240@red-moon>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-8-lorenzo.pieralisi@arm.com>
 <20170426151257.GA4489@lunn.ch> <20170426161335.GA12240@red-moon>
Message-ID: <20170426185348.GB14074@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Note that IRQ 12 has disappeared from Flags: on 0000:00:00.0.
> 
> Thank you for testing it, that's exactly what we need.
> 
> To check if the plumbing is working (ie to check I have not messed
> up the bus scan API rework), mind testing the patch below please
> and report back (it applies on top of this series) ?

0000:00:00.0 Memory controller: Marvell Technology Group Ltd. 88f5182 [Orion-NAS] ARM SoC (rev 02)
        Subsystem: Marvell Technology Group Ltd. Device 11ab
        Flags: bus master, fast devsel, latency 0, IRQ 12

The interrupt is back with this patch.

    Andrew
