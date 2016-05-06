From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 06 May 2016 14:35:24 +0200
Subject: [PATCH v2 0/4] Amlogic: GXBB: Add pin controller
In-Reply-To: <1462176138-29433-1-git-send-email-carlo@caione.org> (Carlo
 Caione's message of "Mon, 2 May 2016 10:02:14 +0200")
References: <1462176138-29433-1-git-send-email-carlo@caione.org>
Message-ID: <m2bn4jbbzn.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Carlo Caione <carlo@caione.org> writes:

> From: Carlo Caione <carlo@endlessm.com>
>
> Patchset to add and enable the pin controller driver on a couple of Amlogic
> boards with a Meson GXBB SoC.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

I tested this series on GXBB odroid-c2 and p200 boards, along with some
additional pins (patches forthcoming)

Tested-by: Kevin Hilman <khilman@baylibre.com>

> Please note that:
> * This patch depends on http://www.spinics.net/lists/devicetree/msg120964.html
>   ([PATCH] ARM64: dts: amlogic: Add hiu and periphs buses).

Linus, with your ack, we could keep this series together, or if you
prefer, you can take patch 1, and Carlo can take the others through his
tree.

> * The platform driver is still missing a lot of muxing configurations. This is
>   because Amlogic still hasn't publicly released documentation for the GXBB.
>   Since Kevin has already this documentation under NDA, he will integrate and
>   complete this driver with a separate submission.

Coming soon...

Kevin
