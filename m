From: drake@endlessm.com (Daniel Drake)
Date: Fri, 14 Sep 2018 14:24:02 +0800
Subject: [PATCH 5/5] ARM: dts: meson8b: Add support for the Endless Mini
 (EC-100)
In-Reply-To: <20180913202203.19636-6-martin.blumenstingl@googlemail.com>
References: <20180913202203.19636-1-martin.blumenstingl@googlemail.com>
 <20180913202203.19636-6-martin.blumenstingl@googlemail.com>
Message-ID: <CAD8Lp47sSFrv9QopqPn6Ohv-2aupeGbX_Bb2dBXubUzFqjK=-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On Fri, Sep 14, 2018 at 4:22 AM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> The Endless Mini (EC-100) is a grapefruit-sized computer based on the
> Amlogic Meson8b (S805) SoC which comes in two variants.

Thanks for your work here, really happy to see this go by!

Would it be possible to adjust the compatible string to
"endless,ec100" without the hyphen to match what we've already been
shipping?

Just curious, is there now working USB and HDMI support in mainline on
this platform?

Thanks!
Daniel
