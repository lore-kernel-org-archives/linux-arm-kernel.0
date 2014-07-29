From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jul 2014 12:56:04 +0200
Subject: [GIT PULL v2][for 3.17] pull request for hisilicon terminal soc
In-Reply-To: <53D750CA.5090405@hisilicon.com>
References: <53D750CA.5090405@hisilicon.com>
Message-ID: <9329037.jXTZlWzWep@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 July 2014 15:44:10 xuwei wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please help to merge pull request for hisilicon terminal soc. 
> 
> Best Regards,
> Wei
> 
> 
> The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
> 
>   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
> 
> are available in the git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/hix5hd2-for-3.17-v2
> 
> for you to fetch changes up to eeea1ab9b53f311f634e87d9208daa564a97dbba:
> 
>   ARM: hisi: remove smp from machine descriptor (2014-07-29 14:54:11 +0800)
> 
> ----------------------------------------------------------------
> ARM: mach-hisi: Hisilicon teminal soc udaptes for 3.17
> 
> - Rename Hi3716 to HiX5HD2
> HiX5HD2 is a SoC with dual Cortex A9 cores for STB market.
> And original Hi3xxx SoC is for mobile market.
> To avoid confusing the two types of SoCs and also because of
> different implementation(SMP, IPs integarted and earlycon configure),
> rename Hi3716 to HIX5HD2 ann add ARCH_HIX5HD2.
> 
> - Add HiX5HD2 STB SoC and development kit board support
> - Change to use power reset driver to reboot for HiX5HD2
> - Add ARCH_HISI for the common configure of hisilicon SoCs
> - Change to use CPU_METHOD_OF_DECLARE for SMP on HiX5HD2 and hi3xxx
> - Enable L2 aux value for Hi3620
> 

Looks all good to me now. I'll wait for Olof to take a second look,
since he had comments as well, and will let him pull it.

Thanks for updating it this quickly to address all my comments!

	Arnd
