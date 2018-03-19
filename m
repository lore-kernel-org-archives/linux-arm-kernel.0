From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 19 Mar 2018 16:39:57 -0700
Subject: [PATCH] ARM64: dts: meson: bump mali450 clk to 744MHz
In-Reply-To: <1520853021-5412-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Mon, 12 Mar 2018 12:10:21 +0100")
References: <1520853021-5412-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hbmfjskhe.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Mali-450 IP can run up to 744MHz, bump the frequency using
> the GP0 PLL clock.
>
> Cc: Michal Lazo <michal.lazo@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.17/dt64,

Thanks,

Kevin
