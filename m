From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Fri, 22 Dec 2017 17:29:40 +0100
Subject: [PATCH 13/14] input: touchscreen: sama5d2_rts: SAMA5D2 Resistive
 touchscreen driver
In-Reply-To: <1513955241-10985-14-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
 <1513955241-10985-14-git-send-email-eugen.hristev@microchip.com>
Message-ID: <CAOFm3uEcmDi-FW=NQLcVVOLph0P65jLgYx2=FEOJ673Ez3O_vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eugen,

On Fri, Dec 22, 2017 at 4:07 PM, Eugen Hristev
<eugen.hristev@microchip.com> wrote:
> This is the implementation of the Microchip SAMA5D2 SOC resistive
> touchscreen driver.

<snip>

> --- /dev/null
> +++ b/drivers/input/touchscreen/sama5d2_rts.c
> @@ -0,0 +1,287 @@
> +/*
> + * Microchip resistive touchscreen (RTS) driver for SAMA5D2.
> + *
> + * Copyright (C) 2017 Microchip Technology,
> + * Author: Eugen Hristev <eugen.hristev@microchip.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + */


IMHO this should be this as a the first line instead as documented in
Thomas patch set [0] :

> +// SPDX-License-Identifier: GPL-2.0

I am just a lowly messenger and my weightless voice is as light as the
down feather of a new born goose. But if you have concerns with using
C++ comment styles as you should, please read Linus [1][2][3],
Thomas[4] and Greg[5] comments on the topic.


[0] https://lkml.org/lkml/2017/12/4/934
[1] https://lkml.org/lkml/2017/11/2/715
[2] https://lkml.org/lkml/2017/11/25/125
[3] https://lkml.org/lkml/2017/11/25/133
[4] https://lkml.org/lkml/2017/11/2/805
[5] https://lkml.org/lkml/2017/10/19/165

-- 
Cordially
Philippe Ombredanne, a kernel licensing scruffy
