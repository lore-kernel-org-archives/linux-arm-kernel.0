From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 07 Mar 2018 17:27:20 -0800
Subject: [PATCH] ARM64: dts: meson-gxbb-wetek: add a wetek specific dtsi
 to cleanup hub and play2
In-Reply-To: <1520353173-9157-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Tue, 6 Mar 2018 17:19:33 +0100")
References: <1520353173-9157-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7htvtrfjbb.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patch adds a specific wetek dtsi to handle the specific Hub and Play2
> boards by no more depending on the p20x dtsi.
> This simplifies the hub and play2 dts and will avoid breaking these
> boards when adding p200 and p201 specific changes.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.17/dt64,

Thanks,

Kevin
