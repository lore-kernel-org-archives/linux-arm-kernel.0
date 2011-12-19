From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Dec 2011 09:56:37 -0800
Subject: [PATCH 12/20] ARM: mach-msm: hook special idle handlers to
 arm_pm_idle
In-Reply-To: <1324288069-21940-13-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
 <1324288069-21940-13-git-send-email-nico@fluxnic.net>
Message-ID: <20111219175636.GJ6464@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [111219 01:42]:
> --- /dev/null
> +++ b/arch/arm/mach-msm/idle.c
> @@ -0,0 +1,49 @@
> +/* arch/arm/mach-msm/idle.c
> + *
> + * Idle processing for MSM7K - work around bugs with SWFI.
> + *
> + * Copyright (c) 2007 QUALCOMM Incorporated.
> + * Copyright (C) 2007 Google, Inc. 

Trailing whitespace here too "<stdin>:62: trailing whitespace.".

Tony
