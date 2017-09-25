From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 25 Sep 2017 16:41:31 +0200
Subject: [PATCH 0/7] PCI: aardvark: improve compatibility with PCI devices
In-Reply-To: <20170908095348.16578-1-thomas.petazzoni@free-electrons.com>
References: <20170908095348.16578-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20170925164131.166bcfac@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Bjorn,

On Fri,  8 Sep 2017 11:53:41 +0200, Thomas Petazzoni wrote:

> This patch series brings a number of fixes to the pci-aardvark driver
> that allows a much larger number of PCIe devices to be used.
> 
> It fixes kernel bug
> https://bugzilla.kernel.org/show_bug.cgi?id=196339, and has been
> tested with an IGB NIC and a Marvell SATA PCIe card, which were not
> working previously.
> 
> They should be taken for the 4.14 cycle, as they are all bug fixes.

Do you have some feedback about this series? It fixes some important
problems (reported by users), so it would be nice to have it in 4.14.

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
