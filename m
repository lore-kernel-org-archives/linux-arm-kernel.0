From: bp@alien8.de (Borislav Petkov)
Date: Mon, 27 Oct 2014 22:59:08 +0100
Subject: [PATCHv2 0/4] Add Altera peripheral memories to EDAC framework
In-Reply-To: <544EBA84.7080109@opensource.altera.com>
References: <1413578029-13205-1-git-send-email-tthayer@opensource.altera.com>
 <544E93F0.3030409@opensource.altera.com>
 <20141027204307.GB4741@pd.tnic>
 <544EBA84.7080109@opensource.altera.com>
Message-ID: <20141027215908.GC4741@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 04:35:00PM -0500, Thor Thayer wrote:
> Should I move the EDAC Device probe and error handling from
> altera_edac_mgr.c to altera_edac.c? Can I mix the MC and Device models
> in the same file?

Right, for basic practical reasons, I'd like to keep all functionality
pertaining to one hw flavour in one compilation unit/one driver. We can
always split them later if a compelling reason emerges.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
