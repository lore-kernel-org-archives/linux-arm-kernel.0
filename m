From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 20 Jul 2017 17:45:21 -0700
Subject: [PATCH RESEND] ARM64: dts: meson-gx: use specific compatible for
 the AO pwms
In-Reply-To: <20170608123955.3571-1-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Thu, 8 Jun 2017 14:39:55 +0200")
References: <b3812e40-cb59-a30f-9558-2926ca49a29a@baylibre.com>
 <20170608123955.3571-1-jbrunet@baylibre.com>
Message-ID: <7hzibysjmm.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Use the specific compatible for AO pwms so the pwms input can
> be correctly set
>
> FDIV4 is not present on the pwm A0, so change kadhas vim input
> clocks to xtal.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Adding this to fixes v4.13-rc since the PWM driver is now merged.

Kevin
