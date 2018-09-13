From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 12 Sep 2018 20:55:24 -0700
Subject: [PATCH] firmware: meson_sm: Add serial number sysfs entry
In-Reply-To: <1532613556-5398-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Thu, 26 Jul 2018 15:59:16 +0200")
References: <1532613556-5398-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hlg86xd8z.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Amlogic Meson SoC Secure Monitor implements a call to retrieve an unique
> SoC ID starting from the GX Family and all new families.
>
> The serial number is simply exposed as a sysfs entry under the firmware
> sysfs directory.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.20/drivers,

Thanks,

Kevin
