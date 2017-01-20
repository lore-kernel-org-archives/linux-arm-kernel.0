From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 20 Jan 2017 18:23:31 +0530
Subject: [PATCH] ARM: dts: da850-lcdk: enable pwm nodes
In-Reply-To: <1484586189-3118-1-git-send-email-fisaksen@baylibre.com>
References: <1484586189-3118-1-git-send-email-fisaksen@baylibre.com>
Message-ID: <8e981b0b-cdff-aed4-b25b-8875465f0bbb@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frode,

On Monday 16 January 2017 10:33 PM, Frode Isaksen wrote:
> Enable the ecap1 and ecap2 pwm nodes for the
> lcdk board.
> Note that the other pwm nodes are not enabled,
> since the pins are shared with ethernet and spi.
> 
> Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
> ---

Looks like the eCAP is available on the headers at the bottom of the
board. While patch like this is fine to be able to test the PWM
functionality, I dont think we should apply it because this can
potentially clash with usage of the pin on daughter card.

Thanks,
Sekhar
