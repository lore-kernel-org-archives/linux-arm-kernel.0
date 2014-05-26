From: bp@alien8.de (Borislav Petkov)
Date: Mon, 26 May 2014 11:57:30 +0200
Subject: [PATCHv5 3/3] edac: altera: Add EDAC support for Altera SoC
 SDRAM Controller
In-Reply-To: <1400169891-29546-4-git-send-email-tthayer@altera.com>
References: <1400169891-29546-1-git-send-email-tthayer@altera.com>
 <1400169891-29546-4-git-send-email-tthayer@altera.com>
Message-ID: <20140526095730.GC25732@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 11:04:51AM -0500, tthayer at altera.com wrote:
> From: Thor Thayer <tthayer@altera.com>
> 
> v2: Use the SDRAM controller registers to calculate memory size
>     instead of the Device Tree. Update To & Cc list. Add maintainer
>     information.
> 
> v3: EDAC driver cleanup based on comments from Mailing list.
> 
> v4: Panic on DBE. Add macro around inject-error reads to prevent
>     them from being optimized out. Remove of_match_ptr since this
>     will always use Device Tree.
> 
> v5: Addition of printk to trigger function to ensure read vars
>     are not optimized out.

Yeah, you could turn those vX: messages into a real commit message -
much better than none at all :-)

Other than that, the edac bits look ok. I'll wait out until you guys've
sorted the devicetree issues so ping me when it is ready to pick up.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
