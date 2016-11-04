From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 04 Nov 2016 13:42:48 -0700
Subject: [PATCH v2 2/5] ARM: bus: da8xx-mstpri: new driver
In-Reply-To: <1477925138-23457-3-git-send-email-bgolaszewski@baylibre.com>
 (Bartosz Golaszewski's message of "Mon, 31 Oct 2016 15:45:35 +0100")
References: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
 <1477925138-23457-3-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <7hlgwz2czb.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartosz Golaszewski <bgolaszewski@baylibre.com> writes:

> Create the driver for the da8xx master peripheral priority
> configuration and implement support for writing to the three
> Master Priority registers on da850 SoCs.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
