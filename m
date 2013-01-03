From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 3 Jan 2013 15:39:31 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130103143931.GA28451@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

Thomas' RFC series incited me to put in some more work on the Tegra PCIe
controller driver. This in turn brought up an old issue: should we move
PCIe controller drivers to some central location rather than keeping
them in machine-specific directories? Last time I brought this up there
was no consensus but I really think there's some value in keeping these
drivers in a common location, especially now that a few people are
starting to work on similar problems. It may also provide some more
momentum to get the various DT implementations factored out of various
architectures.

Stephen proposed drivers/pci/host on IRC and I second that.

Bjorn, is this something you would be on board with?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130103/5b28ff44/attachment.sig>
