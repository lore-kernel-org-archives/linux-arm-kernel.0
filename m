From: eric@anholt.net (Eric Anholt)
Date: Mon, 30 Jan 2017 15:32:15 -0800
Subject: [PATCH 2/2] ARM: bcm2835: dts: fix uart0/uart1 pins
In-Reply-To: <e0f527a24b0048daba88ef36d5324245e003111c.1485719591.git.baruch@tkos.co.il>
References: <9290fa9eed6b5ff1c5c96b9dac41eca286b7eef9.1485719591.git.baruch@tkos.co.il>
 <e0f527a24b0048daba88ef36d5324245e003111c.1485719591.git.baruch@tkos.co.il>
Message-ID: <87sho0unsw.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Baruch Siach <baruch@tkos.co.il> writes:

> According to the BCM2835 ARM Peripherals document uart1 doesn't map to pins
> 36-39, but uart0 does.
>
> Also, split into separate Rx/Tx and CST/RTS groups to match other uart nodes.
>
> Fixes: 21ff843931b ("ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

These look good, too.  Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170130/e7f67085/attachment.sig>
