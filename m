From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 14 Jul 2010 15:33:39 +0200
Subject: [PATCH 1/3] mx51_3ds: Add support for the imx51 3-stack board
In-Reply-To: <1279026162-6634-2-git-send-email-jason77.wang@gmail.com>
References: <1279026162-6634-1-git-send-email-jason77.wang@gmail.com>
	<1279026162-6634-2-git-send-email-jason77.wang@gmail.com>
Message-ID: <20100714133339.GC18343@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Tue, Jul 13, 2010 at 09:02:39PM +0800, Jason Wang wrote:
> new file mode 100644
> index 0000000..b51da63
> --- /dev/null
> +++ b/arch/arm/mach-mx5/board-mx51_3ds.c
> @@ -0,0 +1,102 @@
> +/*
> + * Copyright 2008-2009 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright (C) 2010 Jason Wang <jason77.wang@gmail.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
I think this is the usual FSL boiler plate, but IMHO this is bogus.
You/they want to have the "version 2 or later" part in the first
senctence, not the second.

(Note, this shouldn't be a nack, just a general comment.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
