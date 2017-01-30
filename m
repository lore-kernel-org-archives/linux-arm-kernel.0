From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 21:17:41 -0800
Subject: [GIT PULL 2/2] ZTE PM domain driver support for 4.11
In-Reply-To: <1485664412-31599-2-git-send-email-shawnguo@kernel.org>
References: <1485664412-31599-1-git-send-email-shawnguo@kernel.org>
 <1485664412-31599-2-git-send-email-shawnguo@kernel.org>
Message-ID: <20170130051741.GV18943@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 12:33:32PM +0800, Shawn Guo wrote:
> The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:
> 
>   Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/zte-pd-4.11
> 
> for you to fetch changes up to 3755584a91c1cb1e50dd24a456e2953fbd276adf:
> 
>   soc: zte: pm_domains: Add support for zx296718 (2017-01-11 16:21:14 +0800)
> 
> ----------------------------------------------------------------
> ZTE PM domain driver support for 4.11:
>  - It includes a series which adds DT bindings and PM domain driver for
>    PCU (Power Control Unit) block found on ZTE ZX2967 family SoC.
> 
> ----------------------------------------------------------------
> Baoyou Xie (5):
>       dt-bindings: zte: add bindings document for zx2967 power domain controller
>       MAINTAINERS: add zx2967 SoC drivers to ARM ZTE architecture
>       soc: zte: Add header for PM domains specifiers
>       soc: zte: pm_domains: Prepare for supporting ARMv8 zx2967 family
>       soc: zte: pm_domains: Add support for zx296718

Merged, thanks!


-Olof
