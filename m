From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 17 Jan 2017 13:34:24 +0100
Subject: [PATCH 00/10] ARM: da850-lcdk: add SATA support
In-Reply-To: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <CAMpxmJVdFhzLGmY8maUo8k1Gzgwp+2ivFD8VqG3SbspFoXNvbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-01-13 13:37 GMT+01:00 Bartosz Golaszewski <bgolaszewski@baylibre.com>:
> This series contains all the changes necessary to make SATA work on
> the da850-lcdk board.
>
> The first patch adds a clock lookup entry required for the ahci core
> to retrieve a functional clock.
>
> The second enables relevant config options for all davinci boards.
>
> The third adds device tree bindings for the ahci_da850 driver.
>
> The fourth adds a workaround for a SATA controller instability we
> detected after increasing the PLL0 frequency for proper LCD
> controller support.
>
> Patches 5 through 7 extend the ahci_da850 driver - add DT support,
> un-hardcode the clock multiplier value and add a workaround for
> a quirk present on the da850 SATA controller.
>
> Patches 8-10 add the device tree changes required to probe the driver.
>
> I'm posting the series as a whole to give all reviewers the full
> picture and visibility of the changes required, if needed I can resend
> the patches separately.
>

Superseded by v2.
