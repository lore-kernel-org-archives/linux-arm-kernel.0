From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 17:20:16 -0800
Subject: [GIT PULL] arm: mediatek: dts changes for v4.11
In-Reply-To: <82e017a8-ade7-b16f-740c-6c106f2f8049@gmail.com>
References: <82e017a8-ade7-b16f-740c-6c106f2f8049@gmail.com>
Message-ID: <20170130012016.GB3133@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 02:46:56PM +0100, Matthias Brugger wrote:
> Hi Arnd, hi Olof,
> 
> Please merge the following changes for 32-bit dts files.
> 
> Thanks,
> Matthias
> 
> ---
> 
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   https://github.com/mbgg/linux-mediatek.git tags/v4.10-next-dts32
> 
> for you to fetch changes up to e348dc74f798c2df31c685bf0c814396f4f3b735:
> 
>   arm: dts: mt2701: Add thermal device node. (2017-01-24 11:24:35 +0100)
> 
> ----------------------------------------------------------------
> Lots of updates for mt2701:
> Rearrange the dt nodes and fix unit address for pincontroler
> Add nodes for:
> - clock controller subsystems
> - scpsys controller
> - iommu and smi
> - spi
> - nand
> - auxadc
> - thermal controller and zones
> 
> Email address updated for mt7623 devicetree files.

Merged, thanks!


-Olof
