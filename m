From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Wed, 22 Aug 2012 08:55:15 +0200
Subject: [PATCH 1/5] i2c: at91: add new fixes for some TWI ip versions
In-Reply-To: <1345559345-13988-2-git-send-email-ludovic.desroches@atmel.com>
References: <1345559345-13988-1-git-send-email-ludovic.desroches@atmel.com>
 <1345559345-13988-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D090EBE8856@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ludovic,

ludovic.desroches at atmel.com wrote on Tuesday, August 21, 2012 4:29 PM
> The at91sam9261 TWI ip version requires also some fixes. The id_entry
> field from the platform device structure has been replaced by the use
> of cpu_is_xxx function to determine when to use these fixes.

I applied your calc_twi_clock() fix using the id_entry stuff instead of
cpu_is_xxx functions as those are deprecated...

I will post the complete series later on. Please test it!

Niko
