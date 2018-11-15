From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 15 Nov 2018 11:54:05 -0800
Subject: [PATCH 0/4] arm64: dts: meson-gx: fix GPIO lines names
In-Reply-To: <1541587550-17842-1-git-send-email-narmstrong@baylibre.com>
References: <1541587550-17842-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hwopedsma.fsf@eze.i-did-not-set--mail-host-address--so-tickle-me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The gpio line names were set in the pinctrl node instead of the gpio node,
> at the time it was merged, it worked, but was obviously wrong.
> This patches moves the properties to the gpio nodes for the board DT having
> the GPIO lines names.

Queued for v4.21 (branch: v4.21/dt64)

Kevin
