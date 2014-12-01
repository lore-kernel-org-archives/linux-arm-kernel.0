From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Dec 2014 22:26:55 +0100
Subject: [PATCH] ARM: zynq: DT: Add USB to device tree
In-Reply-To: <1417459352-23401-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1417459352-23401-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <7088901.UGmPabvHQ0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 December 2014 10:42:32 Soren Brinkmann wrote:
> +       usb_phy0: usb-phy at 0 {
> +               compatible = "usb-nop-xceiv";
> +               #phy-cells = <0>;
> +       };
>  };

As discussed in an unrelated thread today, please drop the "@0" in the
node name, since the device has no 'reg' property.

Otherwise looks good.

	Arnd
