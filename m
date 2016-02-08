From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 8 Feb 2016 18:19:42 +0100
Subject: [PATCH] ARM: dts: sunxi: Fix #interrupt-cells for PIO in H3
In-Reply-To: <20160208093113.GA6268@box2.japko.eu>
References: <20160208093113.GA6268@box2.japko.eu>
Message-ID: <20160208171942.GI31506@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 10:31:14AM +0100, Krzysztof Adamski wrote:
> pinctrl-sunxi uses 3 cells to describe interrupt, not 2. It's bank
> number, pin number and flags.
> 
> Signed-off-by: Krzysztof Adamski <k@japko.eu>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160208/5f66310f/attachment.sig>
