From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 19:35:27 -0700
Subject: [GIT PULL] ARM: mediatek: armv8 DTS for v4.13
In-Reply-To: <a6d19346-24a8-b130-607c-9116c34b673b@gmail.com>
References: <a6d19346-24a8-b130-607c-9116c34b673b@gmail.com>
Message-ID: <20170619023527.GW30022@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 12:34:58PM +0200, Matthias Brugger wrote:
> Hi Olof and Arnd,
> 
> Please find below the relevant branch with updates for arm64 device tree
> files and device tree bindings for v4.13.
> 
> Thanks a lot,
> Matthias
> 
> ---
> 
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/mbgg/linux-mediatek.git tags/v4.12-next-dts64
> 
> for you to fetch changes up to 5f0047466e3c653ffc95fe72e1ea19b1f9927e48:
> 
>   dt-bindings: mediatek: add bindings for MediaTek MT7622 SoC (2017-06-08
> 15:27:16 +0200)
> 
> ----------------------------------------------------------------
> Add device tree nodes for
> mt8173:
> - split USB SuperSpeed port in HighSpeed and SuperSpeed ports.
> - move USB phy clocks up in hierarchy to met new bindings description
> - move MDP nodes up in hierarchy to met new bindings description
> 
> mt6797:
> - add basic SoC support
> - add clock driver
> - add power domain
> 
> dt-bindings:
> - clean-up i2c binding description
> - add binding for mt2701 i2c node
> - add fallback compatible to scpsys binding description
> - add bindings description for mt7622 and mt6796

Merged, thanks!


-Olof
