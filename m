From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 28 Nov 2018 16:47:16 -0800
Subject: [PATCH v5 13/17] clk: sunxi-ng: add support for suniv F1C100s SoC
In-Reply-To: <cc1357c9272628b4d89af007cead83117d9ba6e9.1543443475.git.mesihkilinc@gmail.com>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
 <cc1357c9272628b4d89af007cead83117d9ba6e9.1543443475.git.mesihkilinc@gmail.com>
Message-ID: <154345243603.88331.17915868280143383591@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Mesih Kilinc (2018-11-28 14:33:23)
> diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> new file mode 100644
> index 0000000..d4bc1b8
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> @@ -0,0 +1,541 @@
> +/*
> + * Copyright (c) 2016 Icenowy Zheng <icenowy@aosc.io>
> + *
> + * SPDX-License-Identifier: GPL-2.0

Please fix this location.

> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>
> diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
> new file mode 100644
> index 0000000..1da687a
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
> @@ -0,0 +1,34 @@
> +/*
> + * Copyright 2017 Icenowy Zheng <icenowy@aosc.io>
> + *
> + * SPDX-License-Identifier: GPL-2.0+

Ditto.

> + */
> +
