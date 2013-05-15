From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 May 2013 21:41:01 +0200
Subject: [RFC 6/8] ARM:stih41x: Add STiH416 SOC support
In-Reply-To: <1368022318-2380-1-git-send-email-srinivas.kandagatla@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022318-2380-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <CACRpkdZ6pdjJe5e7FdZPS-nCgRY3MGh3aewB36KJM7z76O-NQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 8, 2013 at 4:11 PM, Srinivas KANDAGATLA
<srinivas.kandagatla@st.com> wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>
> The STiH416 is advanced HD AVC processor with 3D graphics acceleration
> and 1.2-GHz ARM Cortex-A9 SMP CPU.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> CC: Stephen Gallimore <stephen.gallimore@st.com>
> CC: Stuart Menefy <stuart.menefy@st.com>

(...)

This stuff is looking really good.

> +++ b/arch/arm/boot/dts/stih416.dtsi
> @@ -0,0 +1,103 @@
> +/*
> + * Copyright (C) 2012 STMicroelectronics Limited.
> + * Author: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * publishhed by the Free Software Foundation.
> + */
> +#include "stih41x.dtsi"
> +#include "stih416-clock.dtsi"
> +#include "stih416-pinctrl.dtsi"

Nice layering here!

> diff --git a/arch/arm/boot/dts/stih416.h b/arch/arm/boot/dts/stih416.h
> new file mode 100644
> index 0000000..2e27792
> --- /dev/null
> +++ b/arch/arm/boot/dts/stih416.h

I've seen that people start to put these into:
include/dt-bindings/

With one include per driver subsystem. I suggest you follow
this pattern.

Yours,
Linus Walleij
