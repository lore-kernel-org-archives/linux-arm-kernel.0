From: adriana.reus@nxp.com (Adriana Reus)
Date: Wed, 19 Jul 2017 14:34:30 +0000
Subject: [PATCH 2/2] clk: imx: imx7d: Remove ARM_M0 clock
In-Reply-To: <20170718231041.GF18179@codeaurora.org>
References: <1500363892-1173-1-git-send-email-adriana.reus@nxp.com>
 <1500363892-1173-3-git-send-email-adriana.reus@nxp.com>
 <20170718231041.GF18179@codeaurora.org>
Message-ID: <1500474869.8952.5.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Ma, 2017-07-18 at 16:10 -0700, Stephen Boyd wrote:
> On 07/18, Adriana Reus wrote:
> > 
> > IMX7d does not have an M0 Core and this particular
> > clock doesn't seem connected to anything else.
> > Remove this entry from the CCM driver and fix index
> > for the remaining clocks.
> > 
> > Signed-off-by: Adriana Reus <adriana.reus@nxp.com>
> [...]
> > 
> > +#define IMX7D_GPT2_ROOT_DIV		305
> > +#define IMX7D_GPT3_ROOT_CLK		306
> > +#define IMX7D_GPT3_ROOT_SRC		307
> > +#define IMX7D_GPT3_ROOT_CG		308
> > +#define IMX7D_GPT3_ROOT_DIV		309
> > +#define IMX7D_GPT4_ROOT_CLK		310
> > +#define IMX7D_GPT4_ROOT_SRC		311
> > +#define IMX7D_GPT4_ROOT_CG		312
> > +#define IMX7D_GPT4_ROOT_DIV		313
> > +#define IMX7D_TRACE_ROOT_CLK		314
> > +#define IMX7D_TRACE_ROOT_SRC		315
> > +#define IMX7D_TRACE_ROOT_CG		316
> > +#define IMX7D_TRACE_ROOT_DIV		317
> > +#define IMX7D_WDOG1_ROOT_CLK		318
> > +#define IMX7D_WDOG_ROOT_SRC		319
> > +#define IMX7D_WDOG_ROOT_CG		320
> > +#define IMX7D_WDOG_ROOT_DIV		321
> > +#define IMX7D_CSI_MCLK_ROOT_CLK		322
> > +#define IMX7D_CSI_MCLK_ROOT_SRC		323
> > +#define IMX7D_CSI_MCLK_ROOT_CG		324
> > +#define IMX7D_CSI_MCLK_ROOT_DIV		325
> > +#define IMX7D_AUDIO_MCLK_ROOT_CLK	326
> > +#define IMX7D_AUDIO_MCLK_ROOT_SRC	327
> > +#define IMX7D_AUDIO_MCLK_ROOT_CG	328
> > +#define IMX7D_AUDIO_MCLK_ROOT_DIV	329
> > +#define IMX7D_WRCLK_ROOT_CLK		330
> > +#define IMX7D_WRCLK_ROOT_SRC		331
> > +#define IMX7D_WRCLK_ROOT_CG		332
> > +#define IMX7D_WRCLK_ROOT_DIV		333
> > +#define IMX7D_CLKO1_ROOT_SRC		334
> > +#define IMX7D_CLKO1_ROOT_CG		335
> > +#define IMX7D_CLKO1_ROOT_DIV		336
> > +#define IMX7D_CLKO2_ROOT_SRC		337
> > +#define IMX7D_CLKO2_ROOT_CG		338
> > +#define IMX7D_CLKO2_ROOT_DIV		339
> > +#define IMX7D_MAIN_AXI_ROOT_PRE_DIV	340
> > +#define IMX7D_DISP_AXI_ROOT_PRE_DIV	341
> > +#define IMX7D_ENET_AXI_ROOT_PRE_DIV	342
> > +#define IMX7D_NAND_USDHC_BUS_ROOT_PRE_DIV 343
> > +#define IMX7D_AHB_CHANNEL_ROOT_PRE_DIV	344
> > +#define IMX7D_USB_HSIC_ROOT_PRE_DIV	345
> > +#define IMX7D_PCIE_CTRL_ROOT_PRE_DIV	346
> > +#define IMX7D_PCIE_PHY_ROOT_PRE_DIV	347
> > +#define IMX7D_EPDC_PIXEL_ROOT_PRE_DIV	348
> > +#define IMX7D_LCDIF_PIXEL_ROOT_PRE_DIV	349
> > +#define IMX7D_MIPI_DSI_ROOT_PRE_DIV	350
> > +#define IMX7D_MIPI_CSI_ROOT_PRE_DIV	351
> > +#define IMX7D_MIPI_DPHY_ROOT_PRE_DIV	352
> > +#define IMX7D_SAI1_ROOT_PRE_DIV		353
> > +#define IMX7D_SAI2_ROOT_PRE_DIV		354
> > +#define IMX7D_SAI3_ROOT_PRE_DIV		355
> > +#define IMX7D_SPDIF_ROOT_PRE_DIV	356
> > +#define IMX7D_ENET1_REF_ROOT_PRE_DIV	357
> > +#define IMX7D_ENET1_TIME_ROOT_PRE_DIV	358
> > +#define IMX7D_ENET2_REF_ROOT_PRE_DIV	359
> > +#define IMX7D_ENET2_TIME_ROOT_PRE_DIV	360
> > +#define IMX7D_ENET_PHY_REF_ROOT_PRE_DIV 361
> > +#define IMX7D_EIM_ROOT_PRE_DIV		362
> > +#define IMX7D_NAND_ROOT_PRE_DIV		363
> > +#define IMX7D_QSPI_ROOT_PRE_DIV		364
> > +#define IMX7D_USDHC1_ROOT_PRE_DIV	365
> > +#define IMX7D_USDHC2_ROOT_PRE_DIV	366
> > +#define IMX7D_USDHC3_ROOT_PRE_DIV	367
> > +#define IMX7D_CAN1_ROOT_PRE_DIV		368
> > +#define IMX7D_CAN2_ROOT_PRE_DIV		369
> > +#define IMX7D_I2C1_ROOT_PRE_DIV		370
> > +#define IMX7D_I2C2_ROOT_PRE_DIV		371
> > +#define IMX7D_I2C3_ROOT_PRE_DIV		372
> > +#define IMX7D_I2C4_ROOT_PRE_DIV		373
> > +#define IMX7D_UART1_ROOT_PRE_DIV	374
> > +#define IMX7D_UART2_ROOT_PRE_DIV	375
> > +#define IMX7D_UART3_ROOT_PRE_DIV	376
> > +#define IMX7D_UART4_ROOT_PRE_DIV	377
> > +#define IMX7D_UART5_ROOT_PRE_DIV	378
> > +#define IMX7D_UART6_ROOT_PRE_DIV	379
> > +#define IMX7D_UART7_ROOT_PRE_DIV	380
> > +#define IMX7D_ECSPI1_ROOT_PRE_DIV	381
> > +#define IMX7D_ECSPI2_ROOT_PRE_DIV	382
> > +#define IMX7D_ECSPI3_ROOT_PRE_DIV	383
> > +#define IMX7D_ECSPI4_ROOT_PRE_DIV	384
> > +#define IMX7D_PWM1_ROOT_PRE_DIV		385
> > +#define IMX7D_PWM2_ROOT_PRE_DIV		386
> > +#define IMX7D_PWM3_ROOT_PRE_DIV		387
> > +#define IMX7D_PWM4_ROOT_PRE_DIV		388
> > +#define IMX7D_FLEXTIMER1_ROOT_PRE_DIV	389
> > +#define IMX7D_FLEXTIMER2_ROOT_PRE_DIV	390
> > +#define IMX7D_SIM1_ROOT_PRE_DIV		391
> > +#define IMX7D_SIM2_ROOT_PRE_DIV		392
> > +#define IMX7D_GPT1_ROOT_PRE_DIV		393
> > +#define IMX7D_GPT2_ROOT_PRE_DIV		394
> > +#define IMX7D_GPT3_ROOT_PRE_DIV		395
> > +#define IMX7D_GPT4_ROOT_PRE_DIV		396
> > +#define IMX7D_TRACE_ROOT_PRE_DIV	397
> > +#define IMX7D_WDOG_ROOT_PRE_DIV		398
> > +#define IMX7D_CSI_MCLK_ROOT_PRE_DIV	399
> > +#define IMX7D_AUDIO_MCLK_ROOT_PRE_DIV	400
> > +#define IMX7D_WRCLK_ROOT_PRE_DIV	401
> > +#define IMX7D_CLKO1_ROOT_PRE_DIV	402
> > +#define IMX7D_CLKO2_ROOT_PRE_DIV	403
> > +#define IMX7D_DRAM_PHYM_ALT_ROOT_PRE_DIV 404
> > +#define IMX7D_DRAM_ALT_ROOT_PRE_DIV	405
> > +#define IMX7D_LVDS1_IN_CLK		406
> > +#define IMX7D_LVDS1_OUT_SEL		407
> > +#define IMX7D_LVDS1_OUT_CLK		408
> > +#define IMX7D_CLK_DUMMY			409
> > +#define IMX7D_GPT_3M_CLK		410
> > +#define IMX7D_OCRAM_CLK			411
> > +#define IMX7D_OCRAM_S_CLK		412
> > +#define IMX7D_WDOG2_ROOT_CLK		413
> > +#define IMX7D_WDOG3_ROOT_CLK		414
> > +#define IMX7D_WDOG4_ROOT_CLK		415
> > +#define IMX7D_SDMA_CORE_CLK		416
> > +#define IMX7D_USB1_MAIN_480M_CLK	417
> > +#define IMX7D_USB_CTRL_CLK		418
> > +#define IMX7D_USB_PHY1_CLK		419
> > +#define IMX7D_USB_PHY2_CLK		420
> > +#define IMX7D_IPG_ROOT_CLK		421
> > +#define IMX7D_SAI1_IPG_CLK		422
> > +#define IMX7D_SAI2_IPG_CLK		423
> > +#define IMX7D_SAI3_IPG_CLK		424
> > +#define IMX7D_PLL_AUDIO_TEST_DIV	425
> > +#define IMX7D_PLL_AUDIO_POST_DIV	426
> > +#define IMX7D_PLL_VIDEO_TEST_DIV	427
> > +#define IMX7D_PLL_VIDEO_POST_DIV	428
> > +#define IMX7D_MU_ROOT_CLK		429
> > +#define IMX7D_SEMA4_HS_ROOT_CLK		430
> > +#define IMX7D_PLL_DRAM_TEST_DIV		431
> > +#define IMX7D_ADC_ROOT_CLK		432
> > +#define IMX7D_CLK_ARM			433
> > +#define IMX7D_CKIL			434
> > +#define IMX7D_OCOTP_CLK			435
> > +#define IMX7D_NAND_RAWNAND_CLK		436
> > +#define IMX7D_NAND_USDHC_BUS_RAWNAND_CLK 437
> > +#define IMX7D_CLK_END			438
> > ?#endif /* __DT_BINDINGS_CLOCK_IMX7D_H */
> 
> Are any of these defines being used already? Please just leave
> the numbers intact and make the ones that don't exist go to
> /dev/null in the driver. That way, we don't break some ABI where
> people were expecting raw numbers to work still.
> 
They're used in the dts file for imx7 but as defines not as raw
values. It's best to be on the safe side though so I'll leave them
alone and send v2.

Thank you
