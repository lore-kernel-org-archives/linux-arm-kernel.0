From: tj@kernel.org (Tejun Heo)
Date: Tue, 24 Jun 2014 18:05:48 -0400
Subject: [PATCH v3 2/8] ata: ahci_imx: warn when disabling ahci link
In-Reply-To: <E1WzNp6-0005dk-Iq@rmk-PC.arm.linux.org.uk>
References: <20140624101901.GL32514@n2100.arm.linux.org.uk>
 <E1WzNp6-0005dk-Iq@rmk-PC.arm.linux.org.uk>
Message-ID: <20140624220548.GH14909@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 11:19:32AM +0100, Russell King wrote:
> When the AHCI link is disabled, it can't be re-enabled except by
> resetting the entire SoC.  Rather than doing this silently print
> some kernel messages to inform the user, along with how to avoid
> this.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

The same patch from an earlier posting got applied to
libata/for-3.16-fixes.

Thanks.

-- 
tejun
