From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 12 Nov 2018 16:34:50 +0100
Subject: [PATCH V2] arm64: dts: sdm630 SoC and Sony Pioneer (Xperia XA2)
 support
In-Reply-To: <20180812142317.19991-1-ctatlor97@gmail.com>
References: <20180812142317.19991-1-ctatlor97@gmail.com>
Message-ID: <61693687.BtxviolxTZ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Craig,

Am Sonntag, 12. August 2018, 16:23:12 CET schrieb Craig Tatlor:
> Initial device tree support for Qualcomm SDM630 SoC and
> Sony Pioneer (Xperia XA2).
> 
> SDM630 is based off of the SDM660 soc and all SDM660 specific drivers are
> compatible with it. SDM660 is also based off of MSM8998 so it uses some
> of its drivers aswell.
> 
> The device tree is based on the CAF 4.4 kernel tree.
> 
> The device can be booted into the initrd with a shell over UART.
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>

With I think core drivers like clk, pinctrl merged in 4.20, do you
plan on respinning the devicetree support or in general continue
working on sdm630/sdm660?

Or do you have some git tree available somewhere, were I can follow
along? I do have interest in supporting a sdm630 phone of my own
but still don't want to duplicate work :-)


Thanks
Heiko
