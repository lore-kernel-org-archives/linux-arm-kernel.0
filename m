From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 22 Jun 2016 11:16:07 -0500
Subject: [PATCH v2 2/3] PCI: host: new PCI host controller driver for
 Aardvark
In-Reply-To: <201606111501.h2bC6u5a%fengguang.wu@intel.com>
References: <1465574056-8787-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <201606111501.h2bC6u5a%fengguang.wu@intel.com>
Message-ID: <20160622161607.GD25485@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 11, 2016 at 03:09:49PM +0800, kbuild test robot wrote:
> Hi,
> 
> [auto build test ERROR on pci/next]
> [also build test ERROR on v4.7-rc2 next-20160609]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Thomas-Petazzoni/Aardvark-PCIe-controller-driver-for-Marvell-Armada-3700/20160611-001044
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> config: x86_64-lkp (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.3-14) 4.9.3
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/of/Kconfig:4:error: recursive dependency detected!

Was there a resolution to this?
