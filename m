From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 13 Oct 2016 22:27:57 +0200
Subject: [PATCH v3 0/3] usb/phy: Add Amlogic Meson8b and GXBB USB support
In-Reply-To: <20161001121900.1168-1-martin.blumenstingl@googlemail.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20161001121900.1168-1-martin.blumenstingl@googlemail.com>
Message-ID: <CAFBinCCoVOxyVYdNxeNyUhAK+T1+gBW0d1oDUgVpOZZHBjN9Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On Sat, Oct 1, 2016 at 2:18 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> Martin Blumenstingl (3):
>   Documentation: dt-bindings: update the meson-usb2-phy example
>   Documentation: dt-bindings: rename meson-usb2-phy to meson8b-usb2-phy
these two already got an ACK by the devicetree maintainers

>   phy: meson: add USB2 PHY support for Meson8b and GXBB
did you already have time to review the USB2 PHY driver from patch 3/3?
please let me know if there's something we have to change, then I'll
take care of it

would you like to get all patches through the PHY tree or should Kevin
take some of these?


Regards,
Martin
