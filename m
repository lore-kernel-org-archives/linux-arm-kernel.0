From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 15 Jun 2016 14:04:23 -0700
Subject: [PATCH] arm64: defconfig: enable stmmac and realtek PHY as modules
In-Reply-To: <CAOi56cUGq87cEm0uhfVS=tVnwPoUCKVF5YX-G0Z_wW_zezYXfA@mail.gmail.com>
References: <1464993495-19018-1-git-send-email-khilman@baylibre.com>
 <CAOi56cUGq87cEm0uhfVS=tVnwPoUCKVF5YX-G0Z_wW_zezYXfA@mail.gmail.com>
Message-ID: <CAOi56cXzqp3uDRUsmies4PKgoZgDdZU3i1yrqt8y0=Qh+VSvSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 11:27 AM, Kevin Hilman <khilman@baylibre.com> wrote:
> Hi Catalin, Will,
>
> On Fri, Jun 3, 2016 at 3:38 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>> Some Amlogic GXBB boards use the stmmac ethernet driver.  Also, enable
>> the realtek PHY used on meson-gxbb-odroidc2.  The micrel PHY used on the
>> meson-gxbb-p20x boards is already enabled.
>>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>
> Gentle reminder ping.

Oops, nevermind.  I guess we've been taking these through arm-soc.
Sorry for the noise.

Kevin
