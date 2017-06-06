From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 06 Jun 2017 16:43:54 -0700
Subject: [PATCH v2] ARM64: dts: meson-gx: Fix sensors reporting from SCP
In-Reply-To: <20170606102342.32166-1-carlo@caione.org> (Carlo Caione's message
 of "Tue, 6 Jun 2017 12:23:42 +0200")
References: <20170606102342.32166-1-carlo@caione.org>
Message-ID: <m2ink8el6t.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Carlo Caione <carlo@caione.org> writes:

> From: Carlo Caione <carlo@endlessm.com>
>
> Switch to use the new compatible for the SCPI sensors so that the
> sensor readings are reported using the correct scale.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

Thanks for the quick respin.

Applied to v4.13/dt64,

Kevin
