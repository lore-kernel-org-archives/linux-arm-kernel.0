From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Thu, 7 Dec 2017 14:25:04 +0100
Subject: [PATCH V7 02/12] clk: sprd: Add common infrastructure
In-Reply-To: <20171207125715.16160-3-chunyan.zhang@spreadtrum.com>
References: <20171207125715.16160-1-chunyan.zhang@spreadtrum.com>
 <20171207125715.16160-3-chunyan.zhang@spreadtrum.com>
Message-ID: <CAOFm3uEuftL5HuRvg+huPkLHEYUAVQzkGfZD0Ksd00Z+e41P=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Chunyan,

On Thu, Dec 7, 2017 at 1:57 PM, Chunyan Zhang
<chunyan.zhang@spreadtrum.com> wrote:
> Added Spreadtrum's clock driver framework together with common
> structures and interface functions.
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

> --- /dev/null
> +++ b/drivers/clk/sprd/common.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Spreadtrum clock infrastructure
> +//
> +// Copyright (C) 2017 Spreadtrum, Inc.
> +// Author: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

Thank you++ for using SPDX ids!

Acked-by:  Philippe Ombredanne <pombredanne@nexb.com>

-- 
Cordially
Philippe Ombredanne
