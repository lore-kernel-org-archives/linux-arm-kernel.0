From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 28 Nov 2018 13:53:04 -0800
Subject: [RFC PATCH v4 13/17] clk: sunxi-ng: add support for suniv F1C100s
 SoC
In-Reply-To: <6fa817af55c7a54cb6ce91710378aafe1369c744.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
 <6fa817af55c7a54cb6ce91710378aafe1369c744.1543131714.git.mesihkilinc@gmail.com>
Message-ID: <154344198484.88331.1207175109618819774@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Mesih Kilinc (2018-11-24 23:43:16)
> diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> new file mode 100644
> index 0000000..d933dba
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> @@ -0,0 +1,536 @@
> +/*
> + * Copyright (c) 2016 Icenowy Zheng <icenowy@aosc.io>
> + *
> + * SPDX-License-Identifier: GPL-2.0

Echoing Rob. Goes on first line.

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

ditto.
