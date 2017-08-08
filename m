From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 08 Aug 2017 14:49:27 -0700
Subject: [PATCH v5.1 1/2] ARM64: dts: meson-gx: use stable UART bindings
 with correct gate clock
In-Reply-To: <1498056132-18508-2-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Wed, 21 Jun 2017 16:42:11 +0200")
References: <1498056132-18508-1-git-send-email-narmstrong@baylibre.com>
 <1498056132-18508-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <7h1solohlk.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> From: Helmut Klein <hgkr.klein@gmail.com>
>
> This patch switches to the stable UART bindings but also add the correct
> gate clock to the non-AO UART nodes for GXBB and GXL SoCs.
>
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Helmut Klein <hgkr.klein@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.14/dt64,

Thanks,

Kevin
