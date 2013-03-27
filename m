From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 27 Mar 2013 11:47:07 +0200
Subject: [PATCH] ARM: mach-imx: clk-busy: Adapt to new the clk_mux
 structure
In-Reply-To: <1364305330-21638-1-git-send-email-fabio.estevam@freescale.com>
References: <1364305330-21638-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130327094707.GG18519@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 02:42:10PM +0100, Fabio Estevam wrote:
> Commit ce4f3313b05 (clk: add table lookup to mux) caused the following build 
> error on imx_v4_v5_defconfig/imx_v6_v7_defconfig:
> 
> arch/arm/mach-imx/clk-busy.c:172:11: error: 'struct clk_mux' has no member named 'width'
> 
> Fix it by passing the 'mask' field.
> 

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>

Thanks for fixing this before I had time to do it.

Cheers,

Peter.
