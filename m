From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 14 Sep 2016 10:24:38 -0700
Subject: [PATCH v2] ARM: dts: da850-lcdk: Add NAND to DT
In-Reply-To: <20160908183324.32389-1-khilman@baylibre.com>
References: <20160908183324.32389-1-khilman@baylibre.com>
Message-ID: <CAOi56cWJpx-+s7h_+qypj-0HOcC2vDs2PLtZbdMO92TzdvECpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On Thu, Sep 8, 2016 at 11:33 AM, Kevin Hilman <khilman@baylibre.com> wrote:
> From: Karl Beldan <kbeldan@baylibre.com>
>
> This adds DT support for the NAND connected to the SoC AEMIF.
> Passed torture hashing a 40MB file on top of UBIFS using subpages.
>
> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> [khilman: add back default partitions from an earlier patch]
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
> Applies on Sekhar's v4.9/dts branch.
>

Looks like you need to respin your DT series for arm-soc due to build
errors.  Can you add this while you're at it so we have 4-bit ECC in
v4.9?

Thanks,

Kevin
