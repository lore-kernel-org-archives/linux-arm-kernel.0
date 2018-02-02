From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 2 Feb 2018 08:44:21 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: enable OP-TEE
In-Reply-To: <1515145235-12062-1-git-send-email-peng.fan@nxp.com>
References: <1515145235-12062-1-git-send-email-peng.fan@nxp.com>
Message-ID: <20180202004420.GB20833@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 05, 2018 at 05:40:35PM +0800, Peng Fan wrote:
> This patch enables configs for Trusted Execution Environment(TEE) and
> Open Portable Trusted Execution Environment(OP-TEE).
> 
> With Linux running in Trustzone non-secure world, OP-TEE OS runs in
> secure world, linux could use secure services provided by OP-TEE.
> With TEE/OP-TEE options selected, use the bindings
> in Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
> to let the driver probe work.
> 
> On i.MX6/7, now the bootflow is U-Boot->OP-TEE->Linux, OP-TEE will
> automatically create that node.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
