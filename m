From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Nov 2018 20:12:05 -0600
Subject: [PATCH v3 2/3] dt-bindings: arm: amlogic: Add support for the
 Smartlabs SML-5442TW
In-Reply-To: <1541706240-30036-3-git-send-email-christianshewitt@gmail.com>
References: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
 <1541706240-30036-1-git-send-email-christianshewitt@gmail.com>
 <1541706240-30036-3-git-send-email-christianshewitt@gmail.com>
Message-ID: <20181113021205.GA6962@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  8 Nov 2018 23:43:52 +0400, Christian Hewitt wrote:
> The SML-5442TW is an STB for O2 Czech IPTV/VOD and DVB-S based on the
> Amlogic P231 reference design using the S905D chipset. Specs:
> 
> 2GB DDR3 RAM
> 8GB eMMC storage
> 10/100 Base-T Ethernet
> 802.11 a/b/g/n/ac + BT 4.1 HS sdio wireless module (QCA9377)
> 2x single colour and 1x dual colour LEDs on the front panel
> 1x reset button on the front panel
> HDMI 2.0 (4k at 60p) video
> Composite video + 2-channel audio output on 3.5mm jack
> S/PDIF audio output
> Single DVB-S tuner (AVL6762/MxL608)
> 2x USB 2.0 ports
> 1x micro SD card slot
> UART pins (internal)
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
