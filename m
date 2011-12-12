From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Dec 2011 10:25:16 -0800
Subject: [PATCH RESEND v5 0/3] Add support for TI814X processor series
In-Reply-To: <1323482305-32155-1-git-send-email-hemantp@ti.com>
References: <1323482305-32155-1-git-send-email-hemantp@ti.com>
Message-ID: <20111212182515.GG31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hemant Pedanekar <hemantp@ti.com> [111209 17:27]:
> This patch set adds support for DM814x/AM387x device series having Cortex-A8
> MPU.
> 
> The technical documents are available from following link:
> 
> http://focus.ti.com/docs/prod/folders/print/tms320dm8148.html
> 
> This series is referred in code as TI814X.
> 
> Since these devices share similar architecture as TI816X devices, existing
> TI816X code is updated to accomodate TI814X support. The code shared across
> TI816X and TI814X devices is updated with TI81XX/ti81xx prefix as applicable,
> while maintaining cpu_is_ti816x() and cpu_is_ti814x() to distinguish specific
> execution differences.

Thanks applying 1 & 2 into soc branch and 3 into board branch.

Regards,

Tony
