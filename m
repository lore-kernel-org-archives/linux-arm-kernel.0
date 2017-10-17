From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 17 Oct 2017 13:07:20 +0200
Subject: [PATCH v2] reset: meson: add level reset support for GX SoC family
In-Reply-To: <1508235558-24860-1-git-send-email-narmstrong@baylibre.com>
References: <1508235558-24860-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1508238440.6854.9.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-10-17 at 12:19 +0200, Neil Armstrong wrote:
> The Amlogic GX SoC family embeds alternate registers to drive the reset
> levels next to the pulse registers.
> 
> This patch adds support for level reset handling on the GX family only.
> 
> The Meson8 family has an alternate way to handle level reset.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied both to reset/next, thanks!

regards
Philipp
