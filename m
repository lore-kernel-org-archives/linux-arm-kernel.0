From: richard@nod.at (Richard Weinberger)
Date: Mon, 04 Jun 2018 15:28:19 +0200
Subject: [Resend PATCH 1/1] mtd: ubi: Update ubi-media.h to dual license
In-Reply-To: <20180604132137.32136-2-lionel.debieve@st.com>
References: <20180604132137.32136-1-lionel.debieve@st.com>
 <20180604132137.32136-2-lionel.debieve@st.com>
Message-ID: <6364434.VVWtcepFll@blindfold>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 4. Juni 2018, 15:21:37 CEST schrieb Lionel Debieve:
> Update license template using SPDX. Move the global layout
> of UBI headers to dual license helping UBI to be the standard
> solution for raw NAND management.
> 
> Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Artem Bityutskiy <dedekind1@gmail.com>
> Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> ---
>  drivers/mtd/ubi/ubi-media.h | 22 +++-------------------
>  1 file changed, 3 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/ubi-media.h b/drivers/mtd/ubi/ubi-media.h
> index bfceae5a890e..195ff8ca8211 100644
> --- a/drivers/mtd/ubi/ubi-media.h
> +++ b/drivers/mtd/ubi/ubi-media.h
> @@ -1,28 +1,12 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
>  /*
> - * Copyright (c) International Business Machines Corp., 2006
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> - * the GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> - *
> + * Copyright (C) International Business Machines Corp., 2006
>   * Authors: Artem Bityutskiy (???????????????? ??????????)
>   *          Thomas Gleixner
>   *          Frank Haverkamp
>   *          Oliver Lohmann
>   *          Andreas Arnez
> - */
> -
> -/*
> + *
>   * This file defines the layout of UBI headers and all the other UBI on-flash
>   * data structures.
>   */
> 

Applied.
Thanks everyone for sorting this out!

Thanks,
//richard
