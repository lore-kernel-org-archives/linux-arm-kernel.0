From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 13:19:28 -0800
Subject: [GIT PULL] SoCFPGA DTS updates for v4.5, part 2
In-Reply-To: <1450681610-14651-1-git-send-email-dinh.linux@gmail.com>
References: <1450681610-14651-1-git-send-email-dinh.linux@gmail.com>
Message-ID: <20151222211928.GD30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 01:06:50AM -0600, Dinh Nguyen wrote:
> Hi Arnd, Kevin and Olof,
> 
> Please consider pulling these 2 patches for v4.5.
> 
> Thanks,
> Dinh
> 
> The following changes since commit 34a315883f60344f2116dcd445388531d09dc066:
> 
>   ARM: socfpga: Add support for DENX MCV SoM and MCVEVK baseboard (2015-11-19 10:15:05 -0600)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_dts_for_v4.5_part_2
> 
> for you to fetch changes up to 91f69147d681e47e2aa2ff7dbf4c5468befa8a1b:
> 
>   ARM: socfpga: dts: Enable MMC support at correct place in the DT (2015-12-21 00:44:21 -0600)

Merged, thanks.


> Marek Vasut (2):
>       ARM: socfpga: Repair incorrectly applied MCV patch
>       ARM: socfpga: dts: Enable MMC support at correct place in the DT

Same nit as several other pull requests today: please use "ARM: dts:
<platform>: ..." as prefix for dt changes on 32-bit.



-Olof
