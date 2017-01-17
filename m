From: olof@lixom.net (Olof Johansson)
Date: Mon, 16 Jan 2017 22:46:48 -0800
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.11 (#1)
In-Reply-To: <87y3ye7ul7.fsf@free-electrons.com>
References: <87y3ye7ul7.fsf@free-electrons.com>
Message-ID: <20170117064648.GR16607@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 06:12:04PM +0100, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the first pull request for dt64 for mvebu for v4.11.
> 
> Gregory
> 
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.11-1
> 
> for you to fetch changes up to 58a748f7dc29d8a7bb74c6cbba6a82425dbba5cc:
> 
>   ARM64: dts: marvell: Correct license text (2017-01-03 16:24:34 +0100)
> 
> ----------------------------------------------------------------
> mvebu dt64 for 4.11 (part 1)
> 
> - Correct license text which was mangled when switching to dual license
> - Add SPI and I2C nodes on Armada 3700(driver support had been already
>   merged)
> - Add support for the ethernet switch on the EspressoBin board (driver
>   support not yet merged)
> 
> ----------------------------------------------------------------
> Alexandre Belloni (1):
>       ARM64: dts: marvell: Correct license text
> 
> Romain Perier (4):
>       arm64: dts: marvell: Add ethernet switch definition for the ESPRESSObin
>       arm64: dts: marvell: Add definition of SPI controller for Armada 3700
>       arm64: dts: marvell: Enable spi0 on the board Armada-3720-db
>       arm64: dts: marvell: Add I2C definitions for the Armada 3700
> 
>  arch/arm64/boot/dts/marvell/armada-371x.dtsi       | 10 +--
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts     | 44 +++++++++++--
>  .../boot/dts/marvell/armada-3720-espressobin.dts   | 76 ++++++++++++++++++++--
>  arch/arm64/boot/dts/marvell/armada-372x.dtsi       | 10 +--
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi       | 39 +++++++++--
>  5 files changed, 154 insertions(+), 25 deletions(-)

Merged, thanks.


-Olof
