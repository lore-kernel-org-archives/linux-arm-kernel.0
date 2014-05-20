From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 May 2014 22:24:11 -0700
Subject: [GIT PULL 2/2] ARM: Keystone DTS updates for 3.16
In-Reply-To: <1399912899-29640-1-git-send-email-santosh.shilimkar@ti.com>
References: <1399912899-29640-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20140520052411.GK18956@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 12:41:39PM -0400, Santosh Shilimkar wrote:
> Hi Arm-soc folks,
> 
> Please pull below keystone DTS updates for 3.16. It merges cleanly with
> arm-soc 'next/dts' head.
> 
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
> 
>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-dts
> 
> for you to fetch changes up to 18131ae615cf20b06860a1b668e0625db714af2e:
> 
>   ARM: dts: keystone-evm: add spi nor flash support (2014-05-12 11:43:59 -0400)
> 
> ----------------------------------------------------------------
> Keystone DTS updates for 3.16
> 
> - Few of address cell warning fixes.
> - Add Lamarr and Edision EVM NOR flash and NAND devices.
> - Update dts to make use of dma-ranges and dma-coherent properties.

As far as I can see, this branch has no dependencies on the soc branch (and the
dma branch), so I've merged it into next/dt.

Thanks,

-Olof
