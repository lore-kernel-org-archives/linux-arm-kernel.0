From: chunkeey@googlemail.com (Christian Lamparter)
Date: Sun, 04 Jun 2017 02:33:50 +0200
Subject: [PATCH v4 1/6] pinctrl: qcom: Add ipq8074 pinctrl driver
In-Reply-To: <1496474875-7190-2-git-send-email-varada@codeaurora.org>
References: <1496474875-7190-1-git-send-email-varada@codeaurora.org>
 <1496474875-7190-2-git-send-email-varada@codeaurora.org>
Message-ID: <3316949.YG4fliAlpW@debian64>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, June 3, 2017 12:57:50 PM CEST Varadarajan Narayanan wrote:
> +- function:
> +       Usage: required
> +       Value type: <string>
> +       Definition: Specify the alternative function to be configured for the
> +                   specified pins. Functions are only valid for gpio pins.
> +                   Valid values are:
> +                   atest_char, atest_char0, atest_char1, atest_char2,
> +                   atest_char3, audio_rxbclk, audio_rxd, audio_rxfsync,
> +                   audio_rxmclk, audio_txbclk, audio_txd, audio_txfsync,
> +                   audio_txmclk, blsp0_i2c, blsp0_spi, blsp0_uart, blsp1_i2c,
> +                   blsp1_spi, blsp1_uart, blsp2_i2c, blsp2_spi, blsp2_uart,
> +                   blsp3_i2c, blsp3_spi, blsp3_spi0, blsp3_spi1, blsp3_spi2,
> +                   blsp3_spi3, blsp3_uart, blsp4_i2c0, blsp4_i2c1, blsp4_spi0,
> +                   blsp4_spi1, blsp4_uart0, blsp4_uart1, blsp5_i2c, blsp5_spi,
> +                   blsp5_uart, burn0, burn1, cri_trng, cri_trng0, cri_trng1,
> +                   cxc0, cxc1, dbg_out, gcc_plltest, gcc_tlmm, gpio, ldo_en,
> +                   ldo_update, led0, led1, led2, mac0_sa0, mac0_sa1, mac1_sa0,
> +                   mac1_sa1, mac1_sa2, mac1_sa3, mac2_sa0, mac2_sa1, mdc,
> +                   mdio, NA, pcie0_clk, pcie0_rst, pcie0_wake, pcie1_clk,
> +                   pcie1_rst, pcie1_wake, pcm_drx, pcm_dtx, pcm_fsync,
> +                   pcm_pclk, pcm_zsi0, pcm_zsi1, prng_rosc, pta1_0, pta1_1,
> +                   pta1_2, pta2_0, pta2_1, pta2_2, pwm0, pwm1, pwm2, pwm3,
> +                   qdss_cti_trig_in_a0, qdss_cti_trig_in_a1,
> +                   qdss_cti_trig_in_b0, qdss_cti_trig_in_b1,
> +                   qdss_cti_trig_out_a0, qdss_cti_trig_out_a1,
> +                   qdss_cti_trig_out_b0, qdss_cti_trig_out_b1,
> +                   qdss_traceclk_a, qdss_traceclk_b, qdss_tracectl_a,
> +                   qdss_tracectl_b, qdss_tracedata_a, qdss_tracedata_b,
> +                   qpic, rx0, rx1, rx2, sd_card, sd_write, tsens_max, wci2a,
> +                   wci2b, wci2c, wci2d, NA

The "NA" function is listed twice. It should be there at all.
