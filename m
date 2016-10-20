From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 20 Oct 2016 10:40:53 -0700
Subject: [PATCH 1/4] ARM64: dts: meson-gxbb: add MMC support
In-Reply-To: <1476963777-1804-2-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Thu, 20 Oct 2016 13:42:54 +0200")
References: <1476963777-1804-1-git-send-email-narmstrong@baylibre.com>
 <1476963777-1804-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <7h4m467wbe.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> From: Kevin Hilman <khilman@baylibre.com>
>
> Add binding and basic support for the SD/eMMC controller on Amlogic
> S905/GXBB devices.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

nit: you added a couple things from my original patch, and it's
customary to make a summary note of changes in the changelog, so before
applying, I added a line here:

[narmstrong: added nodes for GX, enabled SDIO on P20x]

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.10/dt64

Kevin
