From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue, 29 May 2018 15:41:14 -0500
Subject: [GIT PULL] ARM: dts: socfpga: NAND fixes for v4.17
In-Reply-To: <20180515134416.11349-1-dinguyen@kernel.org>
References: <20180515134416.11349-1-dinguyen@kernel.org>
Message-ID: <8294255f-e5c4-ce03-ca90-016eacbf6cc9@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping?

On 05/15/2018 08:44 AM, Dinh Nguyen wrote:
> Hi Arnd, Kevin, and Olof:
> 
> Please pull in these NAND fixes for v4.17.
> 
> Thanks,
> Dinh
> 
> The following changes since commit 67b8d5c7081221efa252e111cd52532ec6d4266f:
> 
>   Linux 4.17-rc5 (2018-05-13 16:15:17 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_nand_fix_v4.17
> 
> for you to fetch changes up to 3877ef7a1ccecaae378c497e1dcddbc2dccb664c:
> 
>   ARM: dts: socfpga: Fix NAND controller node compatible for Arria10 (2018-05-14 10:16:56 -0500)
> 
> ----------------------------------------------------------------
> ARM: dts: socfpga: fix NAND support
> - NAND should be using nand_x_clk, not nand_clk
> - fix NAND node compatible for Cyclone5 and Arria10
> 
> ----------------------------------------------------------------
> Dinh Nguyen (1):
>       ARM: dts: socfpga: Fix NAND controller node compatible for Arria10
> 
> Marek Vasut (2):
>       ARM: dts: socfpga: Fix NAND controller clock supply
>       ARM: dts: socfpga: Fix NAND controller node compatible
> 
>  arch/arm/boot/dts/socfpga.dtsi         | 4 ++--
>  arch/arm/boot/dts/socfpga_arria10.dtsi | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
