From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 27 Nov 2017 15:33:25 -0800
Subject: [PATCH] ARM64: dts: meson-gxl: Add alternate ARM Trusted Firmware
 reserved memory zone
In-Reply-To: <1507735392-20005-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Wed, 11 Oct 2017 17:23:12 +0200")
References: <1507735392-20005-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7h8tere1q2.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

Neil Armstrong <narmstrong@baylibre.com> writes:

> This year, Amlogic updated the ARM Trusted Firmware reserved memory mapping
> for Meson GXL SoCs and products sold since May 2017 uses this alternate
> reserved memory mapping.
> But products had been sold using the previous mapping.
>
> This issue has been explained in [1] and a dynamic solution is yet to be
> found to avoid loosing another 3Mbytes of reservable memory.
>
> In the meantime, this patch adds this alternate memory zone only for
> the GXL and GXM SoCs since GXBB based new products stopped earlier.
>
> [1] http://lists.infradead.org/pipermail/linux-amlogic/2017-October/004860.html
>
> Fixes: bba8e3f42736 ("ARM64: dts: meson-gx: Add firmware reserved memory zones")
> Reported-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

I missed the Fixes tag on this one, but it's now commit 4ee8e51b9edf upstream.

Please apply to stable v4.10+

Thanks,

Kevin
