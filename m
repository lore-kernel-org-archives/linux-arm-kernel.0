From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 15 Dec 2017 09:49:11 +0800
Subject: [PATCH v7 6/6] arm64: dts: meson-axg: switch uart_ao clock to
 CLK81
In-Reply-To: <1513270051.2261.11.camel@baylibre.com>
References: <20171211141348.22048-1-yixun.lan@amlogic.com>
 <20171211141348.22048-7-yixun.lan@amlogic.com>
 <1513270051.2261.11.camel@baylibre.com>
Message-ID: <b4e29e22-c0e9-1085-fbb7-eabc5c361445@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/15/17 00:47, Jerome Brunet wrote:
> On Mon, 2017-12-11 at 22:13 +0800, Yixun Lan wrote:
>> Switch the uart_ao pclk to CLK81 since the clock driver is ready.
>> Also move the clock info to the board.dts instead in the soc.dtsi.
> 
> Same comment as for ethmac, is it really wise ?
> Isn't the clock setup the same for the axg family ?
> 
HI Jerome:
yes, should be same for AXG family


HI Kevin:
could you take the patch [5/6]? then I just need to resend for this one


Yixun
