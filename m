From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Mon, 12 Feb 2018 11:58:53 +0100
Subject: [RFC PATCH] soc: zynqmp: Add support for tap delay settings
In-Reply-To: <1518431703-32649-1-git-send-email-mnarani@xilinx.com>
References: <1518431703-32649-1-git-send-email-mnarani@xilinx.com>
Message-ID: <CAOFm3uEj2jEu=BW_sbtPx5izP1aeXzyV0j7eBanLyMkdeRQ9Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 11:35 AM, Manish Narani
<manish.narani@xilinx.com> wrote:
> This patch add support for tep delays programming for zynqmp platform.
> This also adds dll reset support.
>
> Signed-off-by: Manish Narani <mnarani@xilinx.com>

<snip>

> --- /dev/null
> +++ b/drivers/soc/xilinx/zynqmp/tap_delays.c
> @@ -0,0 +1,270 @@
> +/*
> + * Xilinx Zynq MPSoC Tap Delay Programming
> + *
> + *  Copyright (C) 2016 Xilinx, Inc.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */

Dear Manish,
Why not using the SPDX ids there too and elsewhere? You are using them
alright in many other places in this patch. See
Documentation/process/license-rules.rst for details
-- 
Cordially
Philippe Ombredanne
