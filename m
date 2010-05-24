From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 24 May 2010 20:55:40 +0200
Subject: [PATCH 05/25] msm: generalize clock support.
In-Reply-To: <1273700754-10256-6-git-send-email-dwalker@codeaurora.org>
References: <>
 <1273700754-10256-6-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100524185540.GA1292@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> --- /dev/null
> +++ b/arch/arm/mach-msm/clock-pcom.h
> @@ -0,0 +1,153 @@
> +/* Copyright (c) 2009, Code Aurora Forum. All rights reserved.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are
> + * met:
> + *     * Redistributions of source code must retain the above copyright
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above
> + *       copyright notice, this list of conditions and the following
> + *       disclaimer in the documentation and/or other materials provided
> + *       with the distribution.
> + *     * Neither the name of Code Aurora Forum, Inc. nor the names of its
> + *       contributors may be used to endorse or promote products derived
> + *       from this software without specific prior written permission.

Is this even GPL compatible?

> diff --git a/arch/arm/mach-msm/clock.c b/arch/arm/mach-msm/clock.c
> index 3b1ce36..34c6a52 100644
> --- a/arch/arm/mach-msm/clock.c
> +++ b/arch/arm/mach-msm/clock.c
> @@ -1,7 +1,7 @@
>  /* arch/arm/mach-msm/clock.c
>   *
>   * Copyright (C) 2007 Google, Inc.
> - * Copyright (c) 2007 QUALCOMM Incorporated
> + * Copyright (c) 2007-2010, Code Aurora Forum. All rights reserved.
>   *
>   * This software is licensed under the terms of the GNU General Public
>   * License version 2, as published by the Free Software Foundation, and

So... what is the relationship between qualcomm and Code Aurora?


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
