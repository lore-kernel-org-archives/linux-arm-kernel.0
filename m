From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 10 Dec 2012 11:59:40 +0100
Subject: [PATCH 0/2] add RTC support for Armada 370 and Armada XP
In-Reply-To: <1355136122-30729-1-git-send-email-gregory.clement@free-electrons.com>
References: <1355136122-30729-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121210105940.GA3392@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 11:42:00AM +0100, Gregory CLEMENT wrote:
> Hello Jason,
> 
> This small patchset adds RTC support for Armada 370 and Armada XP. It
> was succesfully tested on the evaluation board. The second patch add
> the lacking documentation for the device tree binding. This serie is
> 3.9 material.

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew
> 
> Thanks,
> 
> 
> Gregory CLEMENT (2):
>   arm: mvebu: add RTC support for Armada 370 and Armada XP
>   rtc: rtc-mv: Add the device tree binding documentation
> 
>  .../devicetree/bindings/rtc/orion-rtc.txt          |   18 ++++++++++++++++++
>  arch/arm/boot/dts/armada-370-xp.dtsi               |    6 ++++++
>  drivers/rtc/Kconfig                                |    2 +-
>  3 files changed, 25 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/orion-rtc.txt
> 
> -- 
> 1.7.9.5
> 
