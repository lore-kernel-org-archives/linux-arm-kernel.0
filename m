From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 8 Jan 2015 09:56:06 +0100
Subject: [PATCH v2 01/21] ARM: tegra: irq: nuke leftovers from non-DT
 support
In-Reply-To: <1420652576-22309-2-git-send-email-marc.zyngier@arm.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150108085605.GC1987@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 05:42:36PM +0000, Marc Zyngier wrote:
> The GIC is now always initialized from DT on tegra, and there is
> no point in keeping non-DT init code.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mach-tegra/irq.c | 8 --------
>  1 file changed, 8 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/127112d7/attachment.sig>
