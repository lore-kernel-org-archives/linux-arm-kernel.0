From: balbi@ti.com (Felipe Balbi)
Date: Fri, 19 Aug 2011 00:55:02 +0300
Subject: [PATCH 1/5] ARM: davinci: da850, omapl138: introduce shared
	da850 reference components
In-Reply-To: <6650d6c73c2f5a8c4825c91cd8940fe88e46ba03.1313702401.git.bengardiner@nanometrics.ca>
References: <cover.1313702401.git.bengardiner@nanometrics.ca>
	<6650d6c73c2f5a8c4825c91cd8940fe88e46ba03.1313702401.git.bengardiner@nanometrics.ca>
Message-ID: <20110818215501.GB21064@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 18, 2011 at 05:50:47PM -0400, Ben Gardiner wrote:
> @@ -0,0 +1,15 @@
> +/*
> + * TI DA850/OMAP-L138 reusable elements of the da850 reference design.
> + *
> + * Copyright (C) 2011 Nanometrics Inc. This file is licensed under
> + * the terms of the GNU General Public License version 2. This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + */
> +
> +#include <mach/da8xx.h>
> +
> +void __init da850_reference_map_io(void)
> +{
> +	da850_init();
> +}

if it's for this oneliner... just initialize .map_io with da850_init.

not sure it's worth to add another file.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110819/eb95b901/attachment-0001.sig>
