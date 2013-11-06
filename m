From: robherring2@gmail.com (Rob Herring)
Date: Wed, 06 Nov 2013 17:24:04 -0600
Subject: undocumented bindings in linux-next
Message-ID: <527ACF94.5080204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This list is newly added compatible strings in ARM dts files in
linux-next without documentation. Unlike my prior list, this is only the
diff of v3.12 to linux-next. I believe I've eliminated all the false
positives. Documentation patches welcome.

287 compatible strings documented
80 compatible strings undocumented

acx565akm
adi,adv7180
adi,adv7393
adi,adv7611
altr,socfpga-perip-clk
at24,24c256
at,24c1024
atmel,24c08
atmel,at91sam9g45-isi
atmel,sam9g46-sha
dallas,ds1672
edt,edt-ft5x06
fsl,fxos8700
fsl,imx28-tx28-sgtl5000
fsl,imx53-voipac-sgtl5000
fsl,imx6q-sabrelite-sgtl5000
fsl,imx6sl-anatop
fsl,imx6sl-iomuxc-gpr
fsl,tzic
fsl,vf610-sai
gw,gsp
ltc,ltc3676
marvell,sky2
mcp,24c02
mxim,ds1339
nvidia,tegra124
nxp,pca9554
onnn,nct1008
pixcir,pixcir_ts
plx,pex8606
plx,pex8609
qt1070
renesas,irqc
renesas,r7s72100
renesas,r8a7778
renesas,r8a7791
renesas,sh-mmcif
rohm,bh1780gli
samsung,exynos5420-dw-mshc-smu
sil,si52147
sil,si53156
sirf,atlas6-ble
sirf,prima2-cphifbg
sirf,prima2-memc
sirf,prima2-memcmon
sirf,prima2-rsc
sirf,prima2-spi
spidev
sst,w25q256
stericsson,cpufreq-ux500
stericsson,db8500-cpufreq-cooling
st-ericsson,u8500
stericsson,u8500-clks
st,m25l1605d
st,nomadik-mtu
st,stw4811
st,stw481x-vmmc
tc3589x
tc3589x-gpio
ti,bq27200
ti,emif-4d5
ti,omap2-mcspi
ti,omap3-1w
ti,omap36xx
ti,omap4430-sdma
ti,omap4-des
ti,omap4-hwspinlock
ti,omap4-mailbox
ti,omap5-mpu
ti,omap5-sham
ti,omap-control-usb
ti,omap-infra
ti,palmas-usb-vid
ti,tlv320aic23
ti,tps659038-pmic
ti,tsc2007
ti,twl4030-pwrbutton
ti,twl5031
tps61052
tsc2005
