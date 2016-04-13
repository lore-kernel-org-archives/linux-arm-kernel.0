From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Apr 2016 15:19:19 -0700
Subject: [GIT PULL] SoCFPGA DTS updates for v4.7
In-Reply-To: <1460404966-3636-1-git-send-email-dinguyen@kernel.org>
References: <1460404966-3636-1-git-send-email-dinguyen@kernel.org>
Message-ID: <20160413221919.GE19945@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 03:02:46PM -0500, Dinh Nguyen wrote:
> Hi Arnd, Kevin, and Olof,
> 
> Please pull in these DTS updates for v4.7.
> 
> Thanks,
> Dinh
> 
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_dts_for_v4.7
> 
> for you to fetch changes up to 249ff32e1f8b6ffa92e1390e371702dd8633bcac:
> 
>   ARM: dts: socfpga: add reset control for USB (2016-04-11 14:04:06 -0500)
> 
> ----------------------------------------------------------------
> SoCFPGA DTS updates for v4.7
> - Update SD/MMC node for Arria10
> - Update Arria10 with clock and interrupt fields for DMA
> - Remove 'phy-addr' from stmmac node
> - Remove ethernet node from Cyclone5 DTSI
> - Add LEDs/KEYs/SWs support on Sockit
> - Add L2 and OCRAM EDAC dts entries
> - Add reset control for USB

Merged, thanks.


-Olof
