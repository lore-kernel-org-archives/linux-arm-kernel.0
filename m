From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 16 Sep 2016 10:55:51 +0800
Subject: [PATCH v5 2/3] arm64: dts: Add ZTE ZX296718 SoC dts and Makefile
In-Reply-To: <1473730926-1034-3-git-send-email-jun.nie@linaro.org>
References: <1473730926-1034-1-git-send-email-jun.nie@linaro.org>
 <1473730926-1034-3-git-send-email-jun.nie@linaro.org>
Message-ID: <20160916025551.GD7398@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2016 at 09:42:05AM +0800, Jun Nie wrote:
> diff --git a/arch/arm64/boot/dts/zte/zx296718-evb.dts b/arch/arm64/boot/dts/zte/zx296718-evb.dts
> new file mode 100644
> index 0000000..820fe1c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/zte/zx296718-evb.dts
> @@ -0,0 +1,29 @@
> +/*
> + * ZTE Ltd. zx296718 Plaform
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * publishhed by the Free Software Foundation.
> + *
> + */

Just found this is still not what's recommended, i.e. GPL/X11 dual
license.  I updated it and applied all 3 patches.

Shawn
