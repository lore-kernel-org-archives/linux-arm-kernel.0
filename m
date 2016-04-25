From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Apr 2016 23:08:16 +0200
Subject: [PULL REQUEST v2] ARM: dts: OXNAS pull request for 4.7
In-Reply-To: <1461605971-19866-1-git-send-email-narmstrong@baylibre.com>
References: <1461605971-19866-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <15379411.TWv0LPzk4B@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 April 2016 19:39:31 Neil Armstrong wrote:
> Neil Armstrong (6):
>       dt-bindings: irq: arm,versatile-fpga: add compatible string for OX810SE SoC
>       dt-bindings: Add Oxford Semiconductor to vendor prefixes
>       ARM: boot: dts: Add Oxford Semiconductor OX810SE dtsi
>       dt-bindings: Add OXNAS bindings
>       dt-bindings: Add Western Digital to vendor prefixes
>       ARM: boot: dts: Add Western Digital My Book World Edition device tree
> 

The contents all look fine, but please rebase these on top of rc3 or
earlier, so we can avoid back-merging rc4 into the arm-soc tree.

	Arnd
