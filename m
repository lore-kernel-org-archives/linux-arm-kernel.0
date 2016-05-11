From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 11 May 2016 11:48:39 +0200
Subject: [PATCH 1/6] pinctrl: meson: Fix eth_tx_en bit index
In-Reply-To: <1462910920-5462-2-git-send-email-serveralex@gmail.com>
 ("Alexander =?utf-8?Q?M=C3=BCller=22's?= message of "Tue, 10 May 2016
 22:08:35 +0200")
References: <1462910920-5462-1-git-send-email-serveralex@gmail.com>
 <1462910920-5462-2-git-send-email-serveralex@gmail.com>
Message-ID: <m2r3d97wnc.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander M?ller <serveralex@gmail.com> writes:

> Fix pinctrl eth_tx_en bit index according to Hardkernel ODROID-C1 datasheet.
>
> Signed-off-by: Alexander M?ller <serveralex@gmail.com>

Tested-by: Kevin Hilman <khilman@baylibre.com>

Linus, with your ack, we can take this through the amlogic tree, or feel
free to merge as a fix as it can go independetly of the rest of the
series if needed.

Kevin
