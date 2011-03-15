From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 15 Mar 2011 11:34:27 +0000
Subject: [PATCHv2 3/9] macb: unify at91 and avr32 platform data
In-Reply-To: <87vczkmy94.fsf@macbook.be.48ers.dk>
References: <1300184096-13937-1-git-send-email-jamie@jamieiles.com>
	<1300184096-13937-4-git-send-email-jamie@jamieiles.com>
	<87vczkmy94.fsf@macbook.be.48ers.dk>
Message-ID: <20110315113427.GE2914@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Tue, Mar 15, 2011 at 12:14:31PM +0100, Peter Korsgaard wrote:
> >>>>> "Jamie" == Jamie Iles <jamie@jamieiles.com> writes:
>  Jamie> +++ b/include/linux/platform_data/macb.h
>  Jamie> @@ -0,0 +1,17 @@
>  Jamie> +/*
>  Jamie> + * Copyright (C) 2004-2006 Atmel Corporation
>  Jamie> + *
>  Jamie> + * This program is free software; you can redistribute it and/or modify
>  Jamie> + * it under the terms of the GNU General Public License version 2 as
>  Jamie> + * published by the Free Software Foundation.
>  Jamie> + */
>  Jamie> +#ifndef __MACB_PDATA_H__
>  Jamie> +#define __MACB_PDATA_H__
>  Jamie> +
>  Jamie> +struct eth_platform_data {
> 
> How about at the same time renaming it to something a bit less generic
> like macb_platform_data?

Yes, that's a fair point.

Jamie
