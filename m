From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 10 Jan 2017 11:27:38 +0800
Subject: [PATCH resend v4 2/3] ARM: dts: imx6: Support Savageboard dual
In-Reply-To: <20170104070436.3425-1-woogyom.kim@gmail.com>
References: <20170104070436.3425-1-woogyom.kim@gmail.com>
Message-ID: <20170110032736.GX20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 04:04:36PM +0900, Milo Kim wrote:
> Common savageboard DT file is used for board support.
> Add the vendor name and specify the dtb file for i.MX6Q build.
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +

The bindings change should be ideally a separate patch.  But since Rob
seems to be fine with it this time, I just applied the whole series.

Shawn

>  arch/arm/boot/dts/Makefile                         |  1 +
>  arch/arm/boot/dts/imx6dl-savageboard.dts           | 51 ++++++++++++++++++++++
>  3 files changed, 53 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-savageboard.dts
