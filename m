From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 06 Dec 2017 16:58:27 -0800
Subject: [PATCH 1/6 v3] mmc: meson-gx-mmc: Fix platform_get_irq's error
 checking
In-Reply-To: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
 (Arvind Yadav's message of "Sun, 19 Nov 2017 10:22:43 +0530")
References: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
Message-ID: <7h4lp3mk0c.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arvind Yadav <arvind.yadav.cs@gmail.com> writes:

> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
