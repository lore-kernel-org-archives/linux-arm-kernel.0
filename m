From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 04 Nov 2016 13:41:45 -0700
Subject: [PATCH v2 1/5] ARM: memory: da8xx-ddrctl: new driver
In-Reply-To: <1477925138-23457-2-git-send-email-bgolaszewski@baylibre.com>
 (Bartosz Golaszewski's message of "Mon, 31 Oct 2016 15:45:34 +0100")
References: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
 <1477925138-23457-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <7hshr72d12.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartosz Golaszewski <bgolaszewski@baylibre.com> writes:

> Create a new driver for the da8xx DDR2/mDDR controller and implement
> support for writing to the Peripheral Bus Burst Priority Register.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
