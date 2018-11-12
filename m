From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 12 Nov 2018 11:20:44 -0800 (PST)
Subject: [PATCH 1/3] dt-bindings: reset: Add bindings for the Meson-AXG
 SoC Reset Controller
In-Reply-To: <20171110084650.31325-1-yixun.lan@amlogic.com>
References: <20171110084650.31325-1-yixun.lan@amlogic.com>
Message-ID: <alpine.DEB.2.21.1811121115520.14703@nanos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yixun,

On Fri, 10 Nov 2017, Yixun Lan wrote:

> +/*
> + *
> + * Copyright (c) 2016 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + *
> + * Copyright (c) 2017 Amlogic, inc.
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD)

There are two things wrong:

  1) The placement. See Documentation/process/license-rules.rst

  2) BSD is not a valid license id. You really have to decide which BSD
     variant to use.

Please get that fixed as especially #2 is broken. The goal of using SPDX is
to provide reliable license information for compliance tools.

Thanks,

	tglx
