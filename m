From: bp@alien8.de (Borislav Petkov)
Date: Wed, 8 Jan 2014 00:02:41 +0100
Subject: [PATCH v4 2/6] genirq: export percpu irq functions for module
 usage
In-Reply-To: <1388434457-4194-3-git-send-email-sboyd@codeaurora.org>
References: <1388434457-4194-1-git-send-email-sboyd@codeaurora.org>
 <1388434457-4194-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140107230240.GF4164@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 30, 2013 at 12:14:13PM -0800, Stephen Boyd wrote:
> In the near future we're going to use these percpu irq functions
> in the Krait CPU EDAC driver. Export them so that the EDAC driver
> can be compiled as a module.
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
