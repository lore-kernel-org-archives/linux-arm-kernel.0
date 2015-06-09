From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 9 Jun 2015 08:55:21 +0800
Subject: [PATCH v9 5/6] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <1432950661-23060-6-git-send-email-bintian.wang@huawei.com>
References: <1432950661-23060-1-git-send-email-bintian.wang@huawei.com>
 <1432950661-23060-6-git-send-email-bintian.wang@huawei.com>
Message-ID: <20150609005521.GA21682@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A minor random comment below.

On Sat, May 30, 2015 at 09:51:00AM +0800, Bintian Wang wrote:
> +		ao_ctrl: ao_ctrl {
> +			compatible = "hisilicon,hi6220-aoctrl", "syscon";
> +			reg = <0x0 0xf7800000 0x0 0x2000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		sys_ctrl: sys_ctrl {
> +			compatible = "hisilicon,hi6220-sysctrl", "syscon";
> +			reg = <0x0 0xf7030000 0x0 0x2000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		media_ctrl: media_ctrl {
> +			compatible = "hisilicon,hi6220-mediactrl", "syscon";
> +			reg = <0x0 0xf4410000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		pm_ctrl: pm_ctrl {

An unit-address should be coded in the node name, when it has a 'reg'
property.

Shawn

> +			compatible = "hisilicon,hi6220-pmctrl", "syscon";
> +			reg = <0x0 0xf7032000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
