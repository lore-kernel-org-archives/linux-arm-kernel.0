From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 14 Feb 2013 00:11:33 +0100
Subject: [PATCH 10/14] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <1357764194-12677-11-git-send-email-thierry.reding@avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-11-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20130214001133.77e6ba06@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Grant Likely,

On Wed, 13 Feb 2013 22:59:50 +0000, Grant Likely wrote:

> There isn't a whole lot of value in this patch without another user.
> I'll need to see the other patches that make use of this.

See the proposed Marvell PCIe driver and Tegra PCIe driver:
 http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/149232.html
 http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/140649.html

Both Thierry (doing the Tegra PCIe driver) and myself (doing the
Marvell PCIe driver) already have fairly long patch series to add
support for the PCIe interfaces in our respective SoC. In order to ease
the process of getting those merged, we'd like to get some of the
base functions we depend on to be merged first, so that our patch
series become a bit smaller and therefore more manageable. My Marvell
PCIe patch series already has 32 patches (including the ones we are
currently discussing), and I will need even more patches for the
upcoming fourth version (due to additional comments made during the
review of the third version of the patch set).

So, it would really be helpful if this base infrastructure, for which
users already exist in the form of submitted patches, that have already
gone through multiple iterations, could be merged.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
