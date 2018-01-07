From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Sun, 7 Jan 2018 12:59:57 +0100
Subject: [PATCH v2 1/6] ARM: at91: add TCB registers definitions
In-Reply-To: <20180105143006.5369-2-alexandre.belloni@free-electrons.com>
References: <20180105143006.5369-1-alexandre.belloni@free-electrons.com>
 <20180105143006.5369-2-alexandre.belloni@free-electrons.com>
Message-ID: <CAOFm3uHsNd8EJ=pXijfgF7GdA2=5u38NjmcgGv7+SZRD7eQRig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 5, 2018 at 3:30 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Add registers and bits definitions for the timer counter blocks found on
> Atmel ARM SoCs.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  include/soc/at91/atmel_tcb.h | 229 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 229 insertions(+)
>  create mode 100644 include/soc/at91/atmel_tcb.h
>
> diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
> new file mode 100644
> index 000000000000..f48e60f8ab92
> --- /dev/null
> +++ b/include/soc/at91/atmel_tcb.h
> @@ -0,0 +1,229 @@
> +/*
> + * Copyright (C) 2016 Atmel
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */

Alexandre,
Would you mind using SPDx tags here like you did in
/drivers/clocksource/timer-atmel-tcb.c ?
Thanks!
-- 
Cordially
Philippe Ombredanne
