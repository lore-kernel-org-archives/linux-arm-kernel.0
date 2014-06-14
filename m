From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 15 Jun 2014 00:31:56 +0200
Subject: [PATCH 2/6] thermal: sti: Introduce ST Thermal core code
In-Reply-To: <1401980819-19962-3-git-send-email-lee.jones@linaro.org>
References: <1401980819-19962-1-git-send-email-lee.jones@linaro.org>
 <1401980819-19962-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20140614223156.GC1389@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2014-06-05 16:06:55, Lee Jones wrote:
> This core is shared by both ST's 'memory mapped' and
> 'system configuration register' based Thermal controllers.
> 
> Signed-off-by: Ajit Pal Singh <ajitpal.singh@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Pavel Machek <pavel@ucw.cz>



> +++ b/drivers/thermal/st/st_thermal.c
> @@ -0,0 +1,313 @@
> +/*
> + * ST Thermal Sensor Driver core routines
> + * Author: Ajit Pal Singh <ajitpal.singh@st.com>
> + *
> + * Copyright (C) 2003-2014 STMicroelectronics (R&D) Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +
> +#include "st_thermal.h"
...
> +/* Callback to get temperature from HW*/

Add space before */, but feel free to do it in followup patch.


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
