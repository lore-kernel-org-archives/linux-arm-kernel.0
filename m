From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Sat, 03 Oct 2015 15:02:28 +0200
Subject: [PATCH v4 25/26] ARM: pxa: magician: Add missing regulator for
 PWM backlight
In-Reply-To: <5609B3E9.60807@tul.cz>
References: <cover.1443472089.git.petr.cvek@tul.cz> <5609B3E9.60807@tul.cz>
Message-ID: <1443877348.4186.43.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 28.09.2015, 23:40 +0200 schrieb Petr Cvek:
> Add a fake regulator, which is required for the correct
> initialization
> of the PWM backlight driver.

Fixed, not fake. Even though we can't control it, the backlight does
have a supply.

> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>

Acked-by: Philipp Zabel <philipp.zabel@gmail.com>

regards
Philipp
