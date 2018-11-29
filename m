From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 28 Nov 2018 16:49:46 -0800
Subject: [PATCH 0/2] ARM: dts: meson: add the timer interrupts and clocks
In-Reply-To: <20181116204235.3925-1-martin.blumenstingl@googlemail.com>
References: <20181116204235.3925-1-martin.blumenstingl@googlemail.com>
Message-ID: <7hzhtsbtcl.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> This is a follow-up of my series "meson6_timer: dt-bindings updates"
> from [0].
> We were missing the interrupts for timer B, C and D. This is harmless
> so far because the meson6_timer driver only implements timer A. Timer
> E doesn't have any interrupt.
>
> Additionally the timer IP block has two clock inputs. This also adds
> them.
>
> NOTE: the alias "timer_abcde" was chosen because there's a second
> timer instance (F..I which are similar to A..D and J which is
> similar to E).

Queued for v4.21 (branch: v4.21/dt)

Kevin
