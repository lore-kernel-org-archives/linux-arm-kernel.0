From: khilman@baylibre.com (Kevin Hilman)
Date: Sat, 22 Jul 2017 08:26:02 -0700
Subject: [PATCH] ARM64: meson-gxl: disable broken eee
In-Reply-To: <20170707013257.18250-1-joseph.kogut@gmail.com> (Joseph Kogut's
 message of "Thu, 6 Jul 2017 18:32:57 -0700")
References: <20170707013257.18250-1-joseph.kogut@gmail.com>
Message-ID: <7ho9scsdbp.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joseph,

Joseph Kogut <joseph.kogut@gmail.com> writes:

> Meson GXL appears to suffer from the same broken eee issue as GXB,
> originally fixed by feb3cbea0946.
>
> This patch disables the broken energy-efficient ethernet for GXL,
> avoiding the tx link breakage.
>
> Signed-off-by: Joseph Kogut <joseph.kogut@gmail.com>

Can you share what platforms you tested to find/fix this problem?

Thanks for the patch!

Kevin
