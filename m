From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed, 11 Oct 2017 03:18:54 -0500
Subject: [PATCH 2/2] arm64: dts: stratix10: enable gpio and leds
In-Reply-To: <20171010212538.3331-2-atull@kernel.org>
References: <20171010212538.3331-1-atull@kernel.org>
 <20171010212538.3331-2-atull@kernel.org>
Message-ID: <e180a731-c7b3-5900-36c1-5943a7b11386@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/10/2017 04:25 PM, Alan Tull wrote:
> Enable gpio and leds for socdk OOBE daughtercard.
> 
> pushbutton PB_SW0 = gpio1.io4
> pushbutton PB_SW1 = gpio1.io5
> LED HPS_LED0      = gpio1.io20
> LED HPS_LED1      = gpio1.io19
> LED HPS_LED2      = gpio1.io21
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
>  .../boot/dts/altera/socfpga_stratix10_socdk.dts    | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

Both patches applied, thanks Alan!

Dinh
