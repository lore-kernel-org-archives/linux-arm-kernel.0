From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Fri, 29 Dec 2017 13:45:47 +0100
Subject: [PATCH v5 05/16] media: rkisp1: add Rockchip ISP1 subdev driver
In-Reply-To: <1514533978-20408-6-git-send-email-zhengsq@rock-chips.com>
References: <1514533978-20408-1-git-send-email-zhengsq@rock-chips.com>
 <1514533978-20408-6-git-send-email-zhengsq@rock-chips.com>
Message-ID: <CAOFm3uEEBvVKrR+HyCQ76gbVNz51Q343gm0JyfPgMxHFawR74w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shunqian,

On Fri, Dec 29, 2017 at 8:52 AM, Shunqian Zheng <zhengsq@rock-chips.com> wrote:
> From: Jacob Chen <jacob2.chen@rock-chips.com>
>
> Add the subdev driver for rockchip isp1.

<snip>

> --- /dev/null
> +++ b/drivers/media/platform/rockchip/isp1/rkisp1.c
> @@ -0,0 +1,1205 @@
> +/*
> + * Rockchip isp1 driver
> + *
> + * Copyright (C) 2017 Rockchip Electronics Co., Ltd.
> + *
> + * This software is available to you under a choice of one of two
> + * licenses.  You may choose to be licensed under the terms of the GNU
> + * General Public License (GPL) Version 2, available from the file
> + * COPYING in the main directory of this source tree, or the
> + * OpenIB.org BSD license below:
> + *
> + *     Redistribution and use in source and binary forms, with or
> + *     without modification, are permitted provided that the following
> + *     conditions are met:
> + *
> + *      - Redistributions of source code must retain the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer.
> + *
> + *      - Redistributions in binary form must reproduce the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer in the documentation and/or other materials
> + *        provided with the distribution.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + */


Do you mind using a simpler SPDX identifier instead of this long
legalese boilerplate?
This is documented in Thomas doc patches. This applies to your entire
patch set of course.
Thanks!

-- 
Cordially
Philippe Ombredanne
