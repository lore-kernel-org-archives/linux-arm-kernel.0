From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 15 Nov 2018 12:26:07 -0800
Subject: [PATCH] drivers: soc: Allow building the amlogic drivers without
 ARCH_MESON
In-Reply-To: <20181112164654.28594-1-mjourdan@baylibre.com>
References: <20181112164654.28594-1-mjourdan@baylibre.com>
Message-ID: <7h7ehedr4w.fsf@eze.i-did-not-set--mail-host-address--so-tickle-me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Jourdan <mjourdan@baylibre.com> writes:

> The current condition makes it difficult to compile the amlogic/
> drivers with COMPILE_TEST, or without ARCH_MESON in general.
>
> Fixes kbuild errors with patch series that depend on drivers in that
> directory, for instance the meson video decoder.
>
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>

Queued for v4.21 (drivers: v4.21/drivers)

Kevin
