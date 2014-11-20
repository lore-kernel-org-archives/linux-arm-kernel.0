From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 13:14:48 +0100
Subject: [GIT PULL 2/3] ARM: keystone: config updates for 3.19
In-Reply-To: <1415843982-5739-2-git-send-email-ssantosh@kernel.org>
References: <1415843982-5739-1-git-send-email-ssantosh@kernel.org>
 <1415843982-5739-2-git-send-email-ssantosh@kernel.org>
Message-ID: <201411201314.49184.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 November 2014, Santosh Shilimkar wrote:
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-soc
> 
> for you to fetch changes up to 97ef1af9b275924406556bfaec528a3e9e2980c7:
> 
>   ARM: keystone: defconfig: add options to enable PCI controller (2014-11-04 10:29:39 -0800)
> 
> ----------------------------------------------------------------
> Keystone config updates for 3.19
> 
>         - Enable PCIE controller and related options
>         - Enable MDIO and ethernet phy options
>         - Enable DSP IRQCHIP option

Pulled into next/defconfig.

Can you send an update so we also enable all of this in multi_v7_defconfig?

Thanks,

	Arnd
