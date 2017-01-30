From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 21:09:25 -0800
Subject: [GIT PULL 4/5] Freescale arm64 device tree updates for 4.11
In-Reply-To: <1485662803-31235-4-git-send-email-shawnguo@kernel.org>
References: <1485662803-31235-1-git-send-email-shawnguo@kernel.org>
 <1485662803-31235-4-git-send-email-shawnguo@kernel.org>
Message-ID: <20170130050925.GS18943@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 12:06:42PM +0800, Shawn Guo wrote:
> The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:
> 
>   Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.11
> 
> for you to fetch changes up to 73447f68d7b2bc1df870da88b0e21d2bc1afc025:
> 
>   dt-bindings: clockgen: Add compatible string for LS1012A (2017-01-29 10:09:47 +0800)
> 
> ----------------------------------------------------------------
> Freescale arm64 device tree updates for 4.11:
>  - Add support for LS1012A SoC which is an ARMv8 SoC with single
>    Cortex-A53 core, and the corresponding board support: FRDM, QDS
>    and RDB.
>  - Enable TMU (Thermal Monitoring Unit) support for LS1046A SoC.
>  - Enable PCA9547 device for ls2080a-rdb board by removing 'disabled'
>    status setting.
> 
> ----------------------------------------------------------------
> Harninder Rai (4):
>       arm64: dts: Add support for FSL's LS1012A SoC
>       Documentation: DT: Add entry for FSL LS1012A RDB, FRDM, QDS boards
>       Documentation: DT: add LS1012A compatible for SCFG and DCFG
>       dt-bindings: clockgen: Add compatible string for LS1012A
> 
> Jia Hongtao (1):
>       arm64: dts: ls1046a: Add TMU device tree support
> 
> Meng Yi (1):
>       arm64: dts: ls2080a-rdb: remove disable status of pca9547

Merged, thanks!


-Olof
