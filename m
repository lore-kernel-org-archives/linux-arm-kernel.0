From: timur@freescale.com (Timur Tabi)
Date: Thu, 7 Oct 2010 16:46:20 -0500
Subject: [PATCH 1/2] ASoC: Add CS4271 codec support
In-Reply-To: <4CAD16A5.1090501@bluewatersys.com>
References: <4CAD16A5.1090501@bluewatersys.com>
Message-ID: <4CAE3FAC.6010508@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ryan Mallon wrote:
> + * For setups with variable MCLKs, pass 0 as 'freq' argument. This will cause
> + * theoretically possible sample rates to be enabled. Call it again with a
> + * proper value set one the external clock is set (most probably you would do
> + * that from a machine's driver 'hw_param' hook.

If you're going to copy/paste parts of my driver verbatim into yours, you should
put something like this in the comments:

	Based on the CS4270 driver by Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
