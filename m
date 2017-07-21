From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 20 Jul 2017 18:02:57 -0700
Subject: [PATCH RESEND] ARM64: dts: meson-gxl-s905x-libretech-cc: fixup
 board definition
In-Reply-To: <20170717160301.32729-1-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Mon, 17 Jul 2017 18:03:01 +0200")
References: <20170717160301.32729-1-jbrunet@baylibre.com>
Message-ID: <7hvammsita.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> The libretech CC derives less from the p212 than initially thought.
> Several voltage regulators are different and the capabilities of the
> sdcard and emmc also differ.
>
> Deriving from the p212 is not convient anymore so the libretech is now
> derived from s905x definition directly.
>
> Fixes: cd84aff1d981 ("ARM64: dts: meson-gxl: Add Libre Technology CC support")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Applied to v4.13/fixes,

Kevin
