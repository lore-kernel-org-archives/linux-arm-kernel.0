From: robh@kernel.org (Rob Herring)
Date: Mon, 22 May 2017 19:49:34 -0500
Subject: [PATCH 03/12] arm64: dts: hikey960: pinctrl: add more pinmux and
 pinconfig
In-Reply-To: <20170517083745.24479-4-guodong.xu@linaro.org>
References: <20170517083745.24479-1-guodong.xu@linaro.org>
 <20170517083745.24479-4-guodong.xu@linaro.org>
Message-ID: <20170523004934.mgdy7d6tktytdbqj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 04:37:36PM +0800, Guodong Xu wrote:
> From: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
> 
> This commit adds more pinmux and pinctrl information for devices
> on HiKey960, including i2c, spi, cam, uart, ufs, pcie, csi, pwr_key,
> isp, sd/sdio, i2s, and usb.
> 
> Signed-off-by: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
> Signed-off-by: Chen Jun <chenjun14@huawei.com>
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> ---
>  .../arm64/boot/dts/hisilicon/hikey960-pinctrl.dtsi | 779 +++++++++++++++++++--
>  1 file changed, 719 insertions(+), 60 deletions(-)

Acked-by: Rob Herring <robh@kernel.org> 
