From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 06:22:57 -0700
Subject: [GIT PULL 4/5] Freescale arm64 device tree updates for 4.12
In-Reply-To: <1491835076-1995-4-git-send-email-shawnguo@kernel.org>
References: <1491835076-1995-1-git-send-email-shawnguo@kernel.org>
 <1491835076-1995-4-git-send-email-shawnguo@kernel.org>
Message-ID: <20170419132257.GI29219@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 10:37:55PM +0800, Shawn Guo wrote:
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.12
> 
> for you to fetch changes up to 6678254bb4a46dc47620f993a4b71480a3c56ee4:
> 
>   dt-bindings: arm: Add entry for FSL LS1088A RDB, QDS boards (2017-04-04 20:57:27 +0800)
> 
> ----------------------------------------------------------------
> Freescale arm64 device tree updates for 4.12:
>  - Add support of LS2088A SoC, which is a derivative of existing
>    LS2080A SoC, and the major difference is on ARM cores.
>  - Add support of LS1088A SoC which includes eight Cortex-A53 cores
>    with 32 KB L1 D-cache and I-cache respectively.
>  - Add crypto and thermal device support for LS1012A platform.
>  - Add ECC register region for SATA device on LS1012A, LS1043A and
>    LS1046A platforms.

Merged, thanks!


-Olof
