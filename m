From: rogerq@ti.com (Roger Quadros)
Date: Wed, 4 Dec 2013 14:22:33 +0200
Subject: 3.13-rc2 phy-twl4030-usb.c - Timeout setting T2 HSUSB PHY DPLL
In-Reply-To: <CAAfyv37aM6SrpuU9fzKA6GKsWn=To5ANOpG_kSX509NjMjdecA@mail.gmail.com>
References: <CAAfyv37aM6SrpuU9fzKA6GKsWn=To5ANOpG_kSX509NjMjdecA@mail.gmail.com>
Message-ID: <529F1E89.6080700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Kishon

On 12/03/2013 11:33 PM, Belisko Marek wrote:
> Hi,
> 
> current 3.13-rcX break usb support on gta04 board (similar to
> beagleboard) when booting via board file.
> 
> In console we can see messages:
>  [ 5227.287841] twl4030_usb twl4030_usb: Timeout setting T2 HSUSB PHY DPLL clock
> [ 5232.936096] omap_musb_mailbox: musb core is not yet ready
> [ 5233.958160] twl4030_usb twl4030_usb: Timeout setting T2 HSUSB PHY DPLL clock
> [ 5235.058227] twl4030_usb twl4030_usb: Timeout setting T2 HSUSB PHY DPLL clock
> 
> Any pointer what could cause that? (in 3.12 usb works fine)
> 
> BR,
> 
> marek
> 
