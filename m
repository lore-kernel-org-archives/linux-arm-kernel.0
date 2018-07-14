From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 14 Jul 2018 16:47:30 +0200
Subject: [PATCH 2/3] dt-bindings: pinctrl: meson-g12a: document pin name
In-Reply-To: <20180704224511.29350-3-yixun.lan@amlogic.com>
References: <20180704224511.29350-1-yixun.lan@amlogic.com>
 <20180704224511.29350-3-yixun.lan@amlogic.com>
Message-ID: <CAFBinCBcsg8CFkTfx1CrZYHrTk0Yz=auDzAxoen4SzneELjgSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yixun,

On Wed, Jul 4, 2018 at 4:49 PM Yixun Lan <yixun.lan@amlogic.com> wrote:
>
> Document the pins for Amlogic's Meson-G12A SoC.
I suggest to combine patch 1 (adding the compatible string) and 2 (this one)

as discussed in the cover letter: it would be great if you could add a
comment (at least to the commit message) stating that GPIOE is
actually located (checked with the ASIC / hardware team) in the AO
bank

> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
with that:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  include/dt-bindings/gpio/meson-g12a-gpio.h | 114 +++++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h
>
> diff --git a/include/dt-bindings/gpio/meson-g12a-gpio.h b/include/dt-bindings/gpio/meson-g12a-gpio.h
> new file mode 100644
> index 000000000000..f7bd69350d18
> --- /dev/null
> +++ b/include/dt-bindings/gpio/meson-g12a-gpio.h
> @@ -0,0 +1,114 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
> +/*
> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
> + * Author: Xingyu Chen <xingyu.chen@amlogic.com>
(since I'm not sure about all the licensing bits:) do we also need a
"Signed-off-by" from Xingyu Chen?


Regards
Martin
