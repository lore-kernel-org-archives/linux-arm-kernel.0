From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 3 Jan 2013 16:09:58 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20130103143931.GA28451@avionic-0098.adnet.avionic-design.de>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130103143931.GA28451@avionic-0098.adnet.avionic-design.de>
Message-ID: <20130103160958.3edf3005@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Thierry Reding,

On Thu, 3 Jan 2013 15:39:31 +0100, Thierry Reding wrote:

> Thomas' RFC series incited me to put in some more work on the Tegra
> PCIe controller driver. This in turn brought up an old issue: should
> we move PCIe controller drivers to some central location rather than
> keeping them in machine-specific directories? Last time I brought
> this up there was no consensus but I really think there's some value
> in keeping these drivers in a common location, especially now that a
> few people are starting to work on similar problems. It may also
> provide some more momentum to get the various DT implementations
> factored out of various architectures.
> 
> Stephen proposed drivers/pci/host on IRC and I second that.

I for sure would be interested in a direction such as this one being
taken for PCI support. Having drivers in a common directory will help
comparing them, extracting common patterns, etc.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
