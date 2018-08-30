From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu, 30 Aug 2018 08:31:13 -0500
Subject: [PATCH] ARM: dts: socfpga: Rename
 socfpga_cyclone5_de0_{sockit,nano_soc}
In-Reply-To: <20180829151504.12013-1-marex@denx.de>
References: <20180829151504.12013-1-marex@denx.de>
Message-ID: <93976fcb-c610-9850-2851-36d095c780a5@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/29/2018 10:15 AM, Marek Vasut wrote:
> Rename DT source for DE0 Nano SoC . The board name is really DE0-Nano-SoC
> or Atlas SoC, and it is not to be confused with SoCkit board, which is a
> different one. Rename the DT source file to match the board name and to
> avoid this possible mixup with another different board.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm/boot/dts/Makefile                                      | 2 +-
>  ...yclone5_de0_sockit.dts => socfpga_cyclone5_de0_nano_soc.dts} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename arch/arm/boot/dts/{socfpga_cyclone5_de0_sockit.dts => socfpga_cyclone5_de0_nano_soc.dts} (100%)

Applied!

Thanks,
Dinh
