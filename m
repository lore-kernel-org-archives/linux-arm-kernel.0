From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 21 Oct 2017 00:04:49 +0200
Subject: [PATCH v2 4/4] ARM: dts: meson: add the efuse node
In-Reply-To: <20171002232804.20042-5-martin.blumenstingl@googlemail.com>
References: <20171002232804.20042-1-martin.blumenstingl@googlemail.com>
 <20171002232804.20042-5-martin.blumenstingl@googlemail.com>
Message-ID: <CAFBinCAtcWERQbH4Q8XRYMyYctwWEj0bX+Ud5oRyhOuOiYjqew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Tue, Oct 3, 2017 at 1:28 AM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> Meson6, Meson8 and Meson8b use a similar IP block which has access to
> 512 bytes of efuse data.
> During SoC manufacturing some calibration settings for the CVBS
> connector and the internal temperature sensor are written to this efuse.
> On some boards it additionally stores for example the MAC addresses.
>
> The efuse is enabled on Meson8 and Meson8b but kept disabled on Meson6
> since we do not have a clock driver there (which is required to read
> data from the efuse).
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  arch/arm/boot/dts/meson.dtsi   | 15 +++++++++++++++
>  arch/arm/boot/dts/meson6.dtsi  |  3 +++
>  arch/arm/boot/dts/meson8.dtsi  |  6 ++++++
>  arch/arm/boot/dts/meson8b.dtsi |  7 +++++++
>  4 files changed, 31 insertions(+)
the dt-binding documentation and driver were queued for v4.15 today.
could you please have a look at this patch and queue it for v4.15 as
well (if everything is fine)?

[snip]


thank you!
Martin
