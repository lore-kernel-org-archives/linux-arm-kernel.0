From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 26 Feb 2016 11:36:35 -0800
Subject: [PATCH v2] ARM: dts: sun8i: Add leds and switch on Orangepi Plus
 boards
In-Reply-To: <20160225204234.GA31610@box2.japko.eu>
References: <20160225204234.GA31610@box2.japko.eu>
Message-ID: <20160226193635.GA8418@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 09:42:35PM +0100, Krzysztof Adamski wrote:
> OrangePi Plus board has dwo leds - green ("pwr") and red ("status")
> and a switch ("sw4"). This patch describes them in a devicetree.
> 
> Signed-off-by: Krzysztof Adamski <k@japko.eu>

Applied (with a minor change to the pinctrl list to have pinctrl-0 =
<&node1>, <&node2>;), thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160226/662ef014/attachment.sig>
