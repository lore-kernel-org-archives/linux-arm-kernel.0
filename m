From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 08 Dec 2017 10:56:22 -0800
Subject: [PATCH] ARM64: dts: meson-gx: fix UART pclk clock name
In-Reply-To: <1512378293-22198-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Mon, 4 Dec 2017 10:04:53 +0100")
References: <1512378293-22198-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hindhm4kp.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The clock-names for pclk was wrongly set to "core", but the bindings
> specifies "pclk".
> This was not cathed until the legacy non-documented bindings were removed.
>
> Reported-by: Andreas F?rber <afaerber@suse.de>
> Fixes: f72d6f6037b7 ("ARM64: dts: meson-gx: use stable UART bindings with correct gate clock")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.15/fixes,

Thanks,

Kevin
