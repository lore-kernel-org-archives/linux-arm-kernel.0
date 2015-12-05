From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 05 Dec 2015 23:13:21 +0100
Subject: [PATCH RESEND net-next 3/3] arm64: hip05-d02: Document devicetree
 bindings for Hisilicon D02 Board
In-Reply-To: <1449302218-54374-4-git-send-email-yankejian@huawei.com>
References: <1449302218-54374-1-git-send-email-yankejian@huawei.com>
 <1449302218-54374-4-git-send-email-yankejian@huawei.com>
Message-ID: <2441219.omPQqZs8vd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 05 December 2015 15:56:58 yankejian wrote:
> +Required properties:
> +- compatible : "hisilicon,peri-c-subctrl", "syscon";
> +- reg : Register address and size
> +
> +The HiP05 PERISUB system controller is shared by peripheral controllers in
> +HiP05 Soc to implement some basic configurations. the peripheral
> + controllers include mdio, ddr, iic, uart, timer and so on.
> +
> +Example:
> +       /* for HiP05 PCIe-SAS system */
> +       pcie_sas: system_controller at 0xb0000000 {
> +               compatible = "hisilicon,pcie-sas-subctrl", "syscon";
> +               reg = <0xb0000000 0x10000>;
> +       };
> 

The compatible string in the example does not match the required properties.

	Arnd
