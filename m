From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 5 Nov 2012 12:35:30 +0100
Subject: [PATCH 3/8] ARM: zynq: dts: add description of the second uart
In-Reply-To: <8c2fac7167cd7c5201d5e1d8e1ceeb183ee2f63f.1351721190.git.josh.cartwright@ni.com>
References: <cover.1351721190.git.josh.cartwright@ni.com>
 <8c2fac7167cd7c5201d5e1d8e1ceeb183ee2f63f.1351721190.git.josh.cartwright@ni.com>
Message-ID: <CAHTX3d+WePMm16xK0Mub9EZMSX9vg_FTFQG-u0vxXXxuv9j4Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/10/31 Josh Cartwright <josh.cartwright@ni.com>:
> The zynq-7000 has an additional UART at 0xE0001000.  Describe it in the
> device tree.
>
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> ---
>  arch/arm/boot/dts/zynq-ep107.dts | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied to my testing branch.

Thanks,
Michal
