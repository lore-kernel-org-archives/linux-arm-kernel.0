From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 1 Nov 2015 10:48:59 +0100
Subject: [PATCH v4 5/6] ARM: dts: sunxi: Add Allwinner H3 DTSI
In-Reply-To: <1445964626-6484-6-git-send-email-jenskuske@gmail.com>
References: <1445964626-6484-1-git-send-email-jenskuske@gmail.com>
 <1445964626-6484-6-git-send-email-jenskuske@gmail.com>
Message-ID: <20151101094859.GR6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 27, 2015 at 05:50:25PM +0100, Jens Kuske wrote:
> +		bus_gates: clk at 01c20060 {
> +			#clock-cells = <1>;
> +			compatible = "allwinner,sun8i-h3-bus-gates-clk";
> +			reg = <0x01c20060 0x14>;
> +			clocks = <&ahb1>, <&ahb2>, <&apb1>, <&apb2>;
> +			clock-names = "ahb1", "ahb2", "apb1", "apb2";
> +			clock-indices = <5>, <6>, <8>,
> +					<9>, <10>, <13>,
> +					<14>, <17>, <18>,
> +					<19>, <20>,
> +					<21>, <23>,
> +					<24>, <25>,
> +					<26>, <27>,
> +					<28>, <29>,
> +					<30>, <31>, <32>,
> +					<35>, <36>, <37>,
> +					<40>, <41>, <43>,
> +					<44>, <52>, <53>,
> +					<54>, <64>,
> +					<65>, <69>, <72>,
> +					<76>, <77>, <78>,
> +					<96>, <97>, <98>,
> +					<112>, <113>,
> +					<114>, <115>, <116>,
> +					<128>, <135>;
> +			clock-output-names = "ahb1_ce", "ahb1_dma", "ahb1_mmc0",
> +					"ahb1_mmc1", "ahb1_mmc2", "ahb1_nand",
> +					"ahb1_sdram", "ahb2_gmac", "ahb1_ts",
> +					"ahb1_hstimer", "ahb1_spi0",
> +					"ahb1_spi1", "ahb1_otg",
> +					"ahb1_otg_ehci0", "ahb1_ehic1",
> +					"ahb1_ehic2", "ahb1_ehic3",
> +					"ahb1_otg_ohci0", "ahb2_ohic1",
> +					"ahb2_ohic2", "ahb2_ohic3", "ahb1_ve",
> +					"ahb1_lcd0", "ahb1_lcd1", "ahb1_deint",
> +					"ahb1_csi", "ahb1_tve", "ahb1_hdmi",
> +					"ahb1_de", "ahb1_gpu", "ahb1_msgbox",
> +					"ahb1_spinlock", "apb1_codec",
> +					"apb1_spdif", "apb1_pio", "apb1_ths",
> +					"apb1_i2s0", "apb1_i2s1", "apb1_i2s2",
> +					"apb2_i2c0", "apb2_i2c1", "apb2_i2c2",
> +					"apb2_uart0", "apb2_uart1",
> +					"apb2_uart2", "apb2_uart3", "apb2_scr",
> +					"ahb1_ephy", "ahb1_dbg";
> +		};

Having the bus clocks called bus_* would make more sense I guess, or
at least it would match the datasheet names (as obscure as they are).

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151101/c74dc351/attachment.sig>
