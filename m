From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Tue, 18 Feb 2014 11:42:43 -0300
Subject: [PATCH v4 0/5] clk: sunxi usb clks support
In-Reply-To: <1391786513-20780-1-git-send-email-hdegoede@redhat.com>
References: <1391786513-20780-1-git-send-email-hdegoede@redhat.com>
Message-ID: <53037163.80103@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

El 07/02/14 12:21, Hans de Goede escribi?:
> Hi All,
>
> And here is v4 of my sunxi usb clks support series.
>
> Changes since v2:
> -rename the compatibilty strings from foo-usb-gates-clk to foo-usb-clk
>
> Changes since v3:
> -rename the compatibilty string for sun4i-usb-clk to sun4i-a10-usb-clk
>
> Note the dts bits (patches 3-5) of this series depends on Chen-Yu Tsai's clk
> rename series.
>
> Emilio, should Mike pick patches 1-2 up directly, or should they go through
> your tree?

I have taken 1-2 on sunxi-clk-for-mike with acks from Maxime and Philipp.

> Maxime, can you please add patches 3-5 to your dts tree ? Assuming that
> wens clk rename patches are already there.

Maxime, please do :)

Cheers, and thanks for working on USB!

Emilio
