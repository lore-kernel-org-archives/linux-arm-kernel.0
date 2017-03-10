From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 10 Mar 2017 14:13:54 -0800
Subject: [PATCH v3 0/2] Add support for HwaCom AmazeTV
In-Reply-To: <20170304202624.29682-1-carlo@caione.org> (Carlo Caione's message
 of "Sat, 4 Mar 2017 21:26:22 +0100")
References: <20170304202624.29682-1-carlo@caione.org>
Message-ID: <m237ekeq59.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Carlo Caione <carlo@caione.org> writes:

> From: Carlo Caione <carlo@endlessm.com>
>
> New DTS to support the HwaCom AmazeTV based on the Meson S905X SoC.
>
> Changelog:
>  v2:
>   - Changed DTS name to meson-gxl-s905x-hwacom-amazetv.dts
>  v3:
>   - Split patchset in two parts: DTS and documentation update
>   - Makefile now sorted alphabetically
>   - DTS nodes now sorted alphabetically
>
> Carlo Caione (2):
>   dt-bindings: amlogic: Add HwaCom board
>   ARM64: dts: meson-gxl: Add support for HwaCom AmazeTV

Applied to v4.12/dt64

Kevin
