From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 30 Jan 2017 10:50:46 -0800
Subject: [PATCH] ARM64: meson-gxbb-p200: add ADC laddered keys
In-Reply-To: <1484562165-29449-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Mon, 16 Jan 2017 11:22:45 +0100")
References: <1484562165-29449-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <m2a8a8tm9l.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Add the 5 buttons connected to a resistor laddered matrix and sampled
> by the SAR ADC channel 0.
>
> Only the p200 board has these buttons, the P201 doesn't.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.11/dt64.

Note that I fixed up the subject prefix to be ARM64: dts:

Kevin
