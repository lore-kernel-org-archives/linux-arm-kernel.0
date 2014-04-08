From: bp@alien8.de (Borislav Petkov)
Date: Tue, 8 Apr 2014 17:39:25 +0200
Subject: [PATCH v6 3/5] devicetree: bindings: Document Krait cache error
 interrupts
In-Reply-To: <1396641450-12854-4-git-send-email-sboyd@codeaurora.org>
References: <1396641450-12854-1-git-send-email-sboyd@codeaurora.org>
 <1396641450-12854-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140408153925.GJ30077@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 04, 2014 at 12:57:28PM -0700, Stephen Boyd wrote:
> The Krait L1/L2 error reporting hardware is made up a per-CPU
> interrupt for the L1 cache and a SPI interrupt for the L2.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/cache.txt | 48 ++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cache.txt b/Documentation/devicetree/bindings/arm/cache.txt
> index b90fcc7c53cf..d7357e777399 100644
> --- a/Documentation/devicetree/bindings/arm/cache.txt
> +++ b/Documentation/devicetree/bindings/arm/cache.txt

Right, that's http://www.spinics.net/lists/arm-kernel/msg308540.html

So whoever picks those patches up, Lorenzo's doc needs to be in his tree
first too.

How about I review the EDAC part and an arm maintainer picks the whole
series up? Would that be easier, logistically?

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
