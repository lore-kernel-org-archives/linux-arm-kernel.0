From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Fri, 16 Feb 2018 13:27:44 +0100
Subject: [PATCH v2 1/1] clk: npcm7xx: add clock controler. fixed clock at
 DT
In-Reply-To: <1518701454-22697-2-git-send-email-tali.perry1@gmail.com>
References: <1518701454-22697-1-git-send-email-tali.perry1@gmail.com>
 <1518701454-22697-2-git-send-email-tali.perry1@gmail.com>
Message-ID: <CAOFm3uHCkv893H_y-fJthNiW0=wO23ddCkZKBdfeiOOF0GAE_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tali,

On Thu, Feb 15, 2018 at 2:30 PM, Tali Perry <tali.perry1@gmail.com> wrote:
> --- /dev/null
> +++ b/drivers/clk/clk-npcm7xx.c
> @@ -0,0 +1,759 @@
> +/*
> + * Nuvoton NPCM7xx Clock Generator
> + * All the clocks are initialized by the bootloader, so this driver allow only
> + * reading of current settings directly from the hardware.
> + *
> + * Copyright (C) 2018 Nuvoton Technologies tali.perry at nuvoton.com
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + * Released under the GPLv2 only.
> + */

Thank you for using the SPDX tags! but this can be streamlined a bit per [1]

The correct way would come out as this: (note the tag placement and
comment style and the removal of the now redundant unstructured
notice)

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Nuvoton NPCM7xx Clock Generator
> + * All the clocks are initialized by the bootloader, so this driver allow only
> + * reading of current settings directly from the hardware.
> + *
> + * Copyright (C) 2018 Nuvoton Technologies tali.perry at nuvoton.com
> + */

And yes you may be surprised by the use of C++ style comment for
this... This has been discussed on list and is what Linus prefers.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
-- 
Cordially
Philippe Ombredanne
