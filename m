From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 13 Feb 2018 16:54:22 +0100
Subject: [PATCH 6/9] ARM: dts: kirkwood: Fix "debounce-interval" property
 misspelling
In-Reply-To: <1518531335-5170-7-git-send-email-geert+renesas@glider.be>
References: <1518531335-5170-1-git-send-email-geert+renesas@glider.be>
 <1518531335-5170-7-git-send-email-geert+renesas@glider.be>
Message-ID: <20180213155422.GC1325@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 03:15:32PM +0100, Geert Uytterhoeven wrote:
> "debounce_interval" was never supported.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hi Geert

Did you notice
Documentation/devicetree/bindings/power/wakeup-source.txt ?  It has
the same problem.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
