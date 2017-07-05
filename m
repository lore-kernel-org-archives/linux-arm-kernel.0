From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 5 Jul 2017 18:01:00 +0200
Subject: [PATCH 2/2] ARM: pm: add missing types include
In-Reply-To: <20170704132542.27644-3-johan@kernel.org>
References: <20170704132542.27644-1-johan@kernel.org>
 <20170704132542.27644-3-johan@kernel.org>
Message-ID: <20170705160057.GD17293@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2017-07-04 15:25:42, Johan Hovold wrote:
> Add missing types.h include to make the suspend header self-contained
> and avoid compilation breakage due to include-directive ordering.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

> +++ b/arch/arm/include/asm/suspend.h
>  #define __ASM_ARM_SUSPEND_H
>  
> +#include <linux/types.h>
> +
>  struct sleep_save_sp {

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
