From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 15 Nov 2018 12:00:41 -0800
Subject: [PATCH RESEND] arm64: dts: meson-gx: Add hdmi_5v regulator as
 hdmi tx supply
In-Reply-To: <1541683478-5173-1-git-send-email-narmstrong@baylibre.com>
References: <1541683478-5173-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hmuqadsba.fsf@eze.i-did-not-set--mail-host-address--so-tickle-me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The hdmi_5v regulator must be enabled to provide power to the physical HDMI
> PHY and enables the HDMI 5V presence loopback for the monitor.
>
> Fixes: b409f625a6d5 ("ARM64: dts: meson-gx: Add HDMI_5V regulator on selected boards")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v4.21 (branch v4.21/dt64)

Kevin
