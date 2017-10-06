From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 06 Oct 2017 15:30:03 -0700
Subject: [PATCH 0/7] ARM: dts: meson: clean pin offsets
In-Reply-To: <20170921171450.27407-1-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Thu, 21 Sep 2017 19:14:43 +0200")
References: <20170921171450.27407-1-jbrunet@baylibre.com>
Message-ID: <7ha8139afo.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> The series is the device-tree part of the series sent to pinctrl [0]
> The present patchset depends on the pinctrl part.
>
> The purpose of this series is to:
> 1) remove the hardcoded gpio offset
> 2) adjust gpio-ranges with respect to the new pin number of each
>    controller
> 3) adjust gpio-line-names accordingly for the boards having this property.
>
> [0]: https://lkml.kernel.org/r/20170918134610.17743-1-jbrunet at baylibre.com

Seeing the driver part is now merged, applying to v4.15/dt64,

Thanks,

Kevin
