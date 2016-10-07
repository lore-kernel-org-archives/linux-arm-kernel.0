From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 07 Oct 2016 06:44:17 -0700
Subject: [PATCH v2 0/2] ARM64: meson-gxbb: Add support for the Nexbox A95X
 Board
In-Reply-To: <1475654980-16414-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Wed, 5 Oct 2016 10:09:38 +0200")
References: <1475654980-16414-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hbmywff4e.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Add support for the Amlogic S905 (GXBB) version of the Nexbox A95X, an IPTV
> set-top-box with Ethernet, SDCard, eMMC, USB, HDMI, IR, Led, Reset button and Audio Jack.
>
> Changes since v1 at: http://lkml.kernel.org/r/1471951370-29269-1-git-send-email-narmstrong at baylibre.com
>  - Rebase on linux-next-20161004 with patchset [1]
>  - Add nexbox vendor prefix
>
> [1] http://lkml.kernel.org/r/1475595430-30075-1-git-send-email-narmstrong at baylibre.com
>
> Neil Armstrong (2):
>   devicetree: Add vendor prefix for Nexbox
>   ARM: dts: meson-gxbb: Add support for the Nexbox A95X Board

Applied to v4.10/dt64 branch,

Kevin
