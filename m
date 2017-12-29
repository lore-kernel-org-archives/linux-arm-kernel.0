From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Fri, 29 Dec 2017 13:57:47 +0100
Subject: [PATCH] ARM: imx: introduce imx_l2c310_write_sec
In-Reply-To: <1514453750-15479-1-git-send-email-peng.fan@nxp.com>
References: <1514453750-15479-1-git-send-email-peng.fan@nxp.com>
Message-ID: <CAOFm3uGDUVvxJgJUYE9bt8iXZ1SwRv3hBceQeOzVdEtt1JfE4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Peng,

On Thu, Dec 28, 2017 at 10:35 AM, Peng Fan <peng.fan@nxp.com> wrote:
> Some PL310 registers could only be wrote in secure world, so
> introduce imx_l2c310_write_sec to support Linux running in
> non-secure world.

<snip>

> --- /dev/null
> +++ b/include/soc/imx/imx_sip_smc.h
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright 2017 NXP
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */

Do you mind using a simpler SPDX identifier instead of this longer
legalese boilerplate? This is documented in Thomas doc patches.
If you could also spread the word in your team that would be much welcomed.
Thanks!

--
Cordially
Philippe Ombredanne
