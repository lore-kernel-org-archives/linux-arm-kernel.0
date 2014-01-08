From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 08 Jan 2014 01:53:45 +0100
Subject: [PATCH RESEND v2 01/12] ARM: exynos4: create a DT header defining
 CLK IDs
In-Reply-To: <1389106060-20291-2-git-send-email-a.hajda@samsung.com>
References: <1389106060-20291-1-git-send-email-a.hajda@samsung.com>
 <1389106060-20291-2-git-send-email-a.hajda@samsung.com>
Message-ID: <3865861.S9945P5El3@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 of January 2014 15:47:29 Andrzej Hajda wrote:
> The patch adds header file defining clock IDs.
> This allows to use macros instead of magic numbers in DT bindings.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  include/dt-bindings/clock/exynos4.h | 244 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 244 insertions(+)
>  create mode 100644 include/dt-bindings/clock/exynos4.h
> 
> diff --git a/include/dt-bindings/clock/exynos4.h b/include/dt-bindings/clock/exynos4.h
> new file mode 100644
> index 0000000..75aff33
> --- /dev/null
> +++ b/include/dt-bindings/clock/exynos4.h
> @@ -0,0 +1,244 @@
> +/*
> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> + * Author: Andrzej Haja <a.hajda@samsung.com>
> + *

Oops, seems like you made a typo in your name here. Let me fix this
when applying. ;)

Best regards,
Tomasz
