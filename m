From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 23 Mar 2017 21:09:52 +0100
Subject: [RFT PATCH 5/6] pinctrl: meson: use gpio-ranges from DT
In-Reply-To: <1490286449-19448-6-git-send-email-narmstrong@baylibre.com>
References: <1490286449-19448-1-git-send-email-narmstrong@baylibre.com>
 <1490286449-19448-6-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAFBinCBa3QuUANF1z3LGk3T9GF-rV5F4WfLGuNCMB2q5juQyOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Thu, Mar 23, 2017 at 5:27 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> When trying to add a gpio-hog, we enter a weird loop where the gpio-ranges
> is needed when gpiochip_add_data() is called but in the current implementation
> the ranges are added from the driver afterwards.
>
> A simple solution is to rely on the DR gpio-ranges attribute and remove the
> call to gpiochip_add_pin_range().
did you mean devicetree or DT instead of "DR"?


Regards,
Martin
