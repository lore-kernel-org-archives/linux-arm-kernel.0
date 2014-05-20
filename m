From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 May 2014 21:54:25 -0700
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.16
In-Reply-To: <20140508153922.GE12708@titan.lakedaemon.net>
References: <20140508153922.GE12708@titan.lakedaemon.net>
Message-ID: <20140520045425.GD18956@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 11:39:22AM -0400, Jason Cooper wrote:
> guys,
> 
> We have a nice round of defconfig changes this time.  Pretty simple,
> based on v3.15-rc1, and been in -next for a while.
> 
> Please pull.
> 
> thx,
> 
> Jason.
> 
> 
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
> 
>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-3.16
> 
> for you to fetch changes up to 208f4e0d9bce775fbc7ab08c830d135d3da5777c:
> 
>   ARM: multi_v5_defconfig: Enable sound modules needed for t5325 (2014-05-05 01:22:11 +0000)
> 
> ----------------------------------------------------------------
> mvebu defconfig changes for v3.16
> 
>  - enable the following:
>     - nfsroot
>     - fhandle
>     - sdhci_pxav3
>     - ahci_mvebu
>     - spi_nor
>     - sound for t5325

Merged, thanks.


-Olof
