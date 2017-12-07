From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 06 Dec 2017 16:55:08 -0800
Subject: [PATCH 1/6] mmc: meson-gx-mmc: Fix platform_get_irq's error
 checking
In-Reply-To: <1510950502-22565-2-git-send-email-arvind.yadav.cs@gmail.com>
 (Arvind Yadav's message of "Sat, 18 Nov 2017 01:58:17 +0530")
References: <1510950502-22565-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1510950502-22565-2-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <7hfu8nmk5v.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arvind Yadav <arvind.yadav.cs@gmail.com> writes:

> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
