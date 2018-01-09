From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 9 Jan 2018 17:35:28 +0800
Subject: [PATCH 6/7] ARM: dts: imx6ull: add IOMUXC SNVS instance
In-Reply-To: <20180102164223.15230-6-stefan@agner.ch>
References: <20180102164223.15230-1-stefan@agner.ch>
 <20180102164223.15230-6-stefan@agner.ch>
Message-ID: <20180109093528.GE26312@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 02, 2018 at 05:42:22PM +0100, Stefan Agner wrote:
> The i.MX 6ULL features another IOMUX Controller called IOMUXC
> SNVS which allows to control BOOT_MODE and TAMPER pins. Add the
> controller to the i.MX 6ULL specific imx6ull.dtsi device tree.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Looks good.
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
