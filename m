From: olof@lixom.net (Olof Johansson)
Date: Mon, 16 Jan 2017 22:24:47 -0800
Subject: [GIT PULL 1/2] SoCFPGA defconfig updates for v4.11
In-Reply-To: <1484165237-26640-1-git-send-email-dinguyen@kernel.org>
References: <1484165237-26640-1-git-send-email-dinguyen@kernel.org>
Message-ID: <20170117062447.GG16607@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 02:07:16PM -0600, Dinh Nguyen wrote:
> Hi Arnd, Kevin, and Olof:
> 
> Please pull in this defconfig update for v4.11.
> 
> Thanks,
> Dinh
> 
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_defconfig_updates_for_v4.11
> 
> for you to fetch changes up to 4fdf18242408cc0b32b3a1a06510376bf609fa60:
> 
>   ARM: socfpga_defconfig: update defconfig for SoCFPGA (2017-01-03 20:29:08 -0600)
> 
> ----------------------------------------------------------------
> SoCFPGA defconfig updates for v4.11
> - enables Marvell PHY support
> - enable MTD(I2C EEPROM), and NAND support
> - enable SPI, RTC and LED support
> - enables OF CONFIGFS to support DTS overlays
> - enables more FS options
> - enables A10 hwmon support
> 
> ----------------------------------------------------------------
> Dinh Nguyen (1):
>       ARM: socfpga_defconfig: update defconfig for SoCFPGA

Hey, look and learn everybody -- you CAN turn on more than one config
options per patch!

(Merged, thanks! :)


-Olof
