From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 7 Dec 2017 13:05:54 +0530
Subject: [PATCH v3] ARM: da850: Fix LEGO EV3 battery voltage gpio
In-Reply-To: <1512338693-16781-1-git-send-email-david@lechnology.com>
References: <1512338693-16781-1-git-send-email-david@lechnology.com>
Message-ID: <1b2fe02d-1c8f-e4e8-53b6-692c4545faf6@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 December 2017 03:34 AM, David Lechner wrote:
> This fixes the battery voltage monitoring gpio-hog settings.
> 
> When the gpio is low, it turns off the battery voltage to the ADC chip.
> However, this needs to be on all of the time so that we can monitor
> battery voltage.
> 
> Also, there was a typo that prevented pinmuxing from working correctly.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Applied to fixes with subject line changed to:

ARM: dts: da850-lego-ev3: Fix battery voltage gpio

Please follow this style for future patches.

Thanks,
Sekhar
