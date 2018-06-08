From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 08 Jun 2018 16:53:40 -0700
Subject: [PATCH] ARM64: dts: meson-gxl-s905x-p212: Add phy-supply for usb0
In-Reply-To: <CAFBinCCF7v40PrtL3HVf9X-fEVx7P2uOVePa5wQ_y6s7uLKmnw@mail.gmail.com>
 (Martin Blumenstingl's message of "Tue, 5 Jun 2018 21:09:09 +0200")
References: <1528188743-12798-1-git-send-email-narmstrong@baylibre.com>
 <CAFBinCCF7v40PrtL3HVf9X-fEVx7P2uOVePa5wQ_y6s7uLKmnw@mail.gmail.com>
Message-ID: <7hsh5wygvv.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> On Tue, Jun 5, 2018 at 10:52 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>> Like LibreTech-CC, the USB0 needs the 5V regulator to be enabled to power the
>> devices on the P212 Reference Design based boards.
>>
>> Fixes: b9f07cb4f41f ("ARM64: dts: meson-gxl-s905x-p212: enable the USB controller")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied to v4.18/fixes (will queue for v4.18-rc).

Kevin
