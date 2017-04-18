From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 18 Apr 2017 20:31:49 +0100
Subject: [PATCH v3] arm64: dts: rk3399: add support for firefly-rk3399
 board
In-Reply-To: <1491796213-4115-1-git-send-email-kever.yang@rock-chips.com>
References: <1491796213-4115-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <20170418203149.1c68ed88@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Apr 2017 11:50:13 +0800
Kever Yang <kever.yang@rock-chips.com> wrote:

> Firefly-rk3399 is a bord from T-Firefly, you can find detail about
> it here:
> http://en.t-firefly.com/en/firenow/Firefly_RK3399/
> 
> This patch add basic node for the board and make it able to bring
> up.
> 
> Peripheral works:
> - usb hub which connect to ehci controller;
> - UART2 debug
> - eMMC
> - PCIe
> 
> Not work:
> - USB 3.0 HOST, type-C port
> - sdio, sd-card
> 
> Not test for other peripheral:

[...]

> - Ethernet

[...]

FWIW, I've tested the Ethernet port, which seems to work nicely.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
