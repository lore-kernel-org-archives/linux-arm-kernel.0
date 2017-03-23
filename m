From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 23 Mar 2017 12:28:58 -0700
Subject: [RESEND PATCH 0/3] ARM64: dts: meson-gx: Cleanup for common nodes
In-Reply-To: <1489396252-28696-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Mon, 13 Mar 2017 10:10:49 +0100")
References: <1489396252-28696-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <m2h92jlrlx.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Since we know the GXBB and GXL/GXM share more hardware, we can safely move
> the remaining peripheral nodes present in the GXBB dtsi to the common GX dtsi.
> The following patches are small cleanups and helps to uniform the GX common
> dtsi compatible scheme.
>
> Changes since original v1 at [1]:
>  - Add back missing changelog on patches 1 and 3

Applied to v4.12/dt64,

Thanks,

Kevin
