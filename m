From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 23:09:23 -0700
Subject: [GIT PULL 4/5] Freescale arm64 device tree updates for 4.13
In-Reply-To: <1497801323-6389-4-git-send-email-shawnguo@kernel.org>
References: <1497801323-6389-1-git-send-email-shawnguo@kernel.org>
 <1497801323-6389-4-git-send-email-shawnguo@kernel.org>
Message-ID: <20170619060923.GG13137@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 18, 2017 at 11:55:22PM +0800, Shawn Guo wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.13
> 
> for you to fetch changes up to 375b6755a5b1836699d00c47f689d63bd1e40b95:
> 
>   arm64: dts: ls1088a: update sata node (2017-06-14 22:42:42 +0800)
> 
> ----------------------------------------------------------------
> The Freescale arm64 device tree updates for 4.13:
>  - A series from NXP employee Li Yang that updates the copyright claims
>    to comply with company policy.
>  - A patch-set from Madalin Bucur that adds Data Path Acceleration
>    Architecture (DPAA) QBMan and FMan.  Quite a few .dtsi files are
>    created for SoCs with different DPAA configuration to include the
>    devices as needed.
>  - Enable UHS-I SD and eMMC support for LS1046A and LS208xA RDB/QDS
>    boards.
>  - Enable TMU device for thermal management support on LS1088A.
>  - Update SATA device node for LS1088A with correct compatible and ECC
>    register bit.
>  - A few small random device tree updates.

Merged, thanks!


-Olof
