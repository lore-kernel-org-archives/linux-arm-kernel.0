From: olof@lixom.net (Olof Johansson)
Date: Mon, 16 Jan 2017 22:25:30 -0800
Subject: [GIT PULL 2/2] SoCFPGA DTS updates for v4.11, part 1
In-Reply-To: <1484165237-26640-2-git-send-email-dinguyen@kernel.org>
References: <1484165237-26640-1-git-send-email-dinguyen@kernel.org>
 <1484165237-26640-2-git-send-email-dinguyen@kernel.org>
Message-ID: <20170117062530.GH16607@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 02:07:17PM -0600, Dinh Nguyen wrote:
> Hi Arnd, Kevin, and Olof:
> 
> Please pull in these DTS updates for v4.11.
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_dts_for_v4.11_part_1
> 
> for you to fetch changes up to 7f0f5460d46867a8f980683136a054cff1357780:
> 
>   ARM: dts: socfpga: add missing compatible string for SDRAM controller (2017-01-06 01:42:06 -0600)
> 
> ----------------------------------------------------------------
> SoCFPGA DTS updates for v4.11, part 1
> - Adds FPGA manager bits
> - Enable I2C on Cyclone5 and Arria5 devkits
> - Adds LED support on C5/A5 devkits
> - Enables CAN on C5 devkit
> - Enables watchdog
> - Add NAND on Arria10
> - Add the LTC2977 Power Monitor on Arria10 devkit

Merged, thanks!


-Olof
