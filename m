From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 27 Jan 2017 09:43:45 -0800
Subject: [PATCH 2/3] mmc: meson-gx: minor improvements in meson_mmc_set_ios
In-Reply-To: <4ec4f0af-c5c9-955c-6158-8c38aa61b358@gmail.com> (Heiner
 Kallweit's message of "Thu, 26 Jan 2017 22:50:25 +0100")
References: <4ec4f0af-c5c9-955c-6158-8c38aa61b358@gmail.com>
Message-ID: <m24m0kwg8e.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> val isn't used in the switch clause and afterwards there's an
> identical statement. So remove it.
>
> In case of an unexpected bus width the error message indicates
> the intention to set the bus width to 4 and to go on.
> So remove the return statement. This return statement also
> conflicts with "setting to 4" because nothing would be set
> actually before returning.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

Thanks for the fix,

Kevin
