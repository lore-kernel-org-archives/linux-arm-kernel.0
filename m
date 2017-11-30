From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Thu, 30 Nov 2017 12:28:26 +0100
Subject: [PATCH v2] clk: stm32-h7: fix copyright
In-Reply-To: <20171130084108.23083-1-benjamin.gaignard@st.com>
References: <20171130084108.23083-1-benjamin.gaignard@st.com>
Message-ID: <CAOFm3uG_7kChnvxW0SbHSMP5q_KSZeaNxjkKb774ZmcwukJ_Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 9:41 AM, Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> Uniformize STMicroelectronics copyrights header
> Add SPDX identifier
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
> CC: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  drivers/clk/clk-stm32h7.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/clk/clk-stm32h7.c b/drivers/clk/clk-stm32h7.c
> index 61c3e40507d3..db2b162c0d4c 100644
> --- a/drivers/clk/clk-stm32h7.c
> +++ b/drivers/clk/clk-stm32h7.c
> @@ -1,20 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) Gabriel Fernandez 2017
> - * Author: Gabriel Fernandez <gabriel.fernandez@st.com>
> - *
> - * License terms: GPL V2.0.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU General Public License,
> - * version 2, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> - *
> - * You should have received a copy of the GNU General Public License along with
> - * this program.  If not, see <http://www.gnu.org/licenses/>.
> + * Copyright (C) STMicroelectronics 2017
> + * Author: Gabriel Fernandez <gabriel.fernandez@st.com> for STMicroelectronics.
>   */
>
>  #include <linux/clk.h>

Awesome! Don't you like it when you remove this type of things?

FWIW,

Reviewed-by: Philippe Ombredanne <pombredanne@nexb.com>

-- 
Cordially
Philippe Ombredanne
