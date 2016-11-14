From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 14 Nov 2016 11:04:15 -0800
Subject: [PATCH] ARM: davinci_all_defconfig: add missing options for
 systemd
In-Reply-To: <20161114160146.20679-1-nsekhar@ti.com> (Sekhar Nori's message of
 "Mon, 14 Nov 2016 21:31:46 +0530")
References: <20161114160146.20679-1-nsekhar@ti.com>
Message-ID: <7hshqt6fyo.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar Nori <nsekhar@ti.com> writes:

> Some kernel configuration options required for systemd
> support are missing in davinci_all_defconfig. Add them.
>
> This is based on recommendations in:
>
>     http://cgit.freedesktop.org/systemd/systemd/tree/README
>
> Options which kernel enables by default (and will thus be removed
> upon next savedefconfig update) are not included.
>
> Tested on OMAP-L138 LCDK board with fully up to date armv5
> archlinux filesystem.
>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
