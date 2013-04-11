From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 11 Apr 2013 14:07:36 -0400
Subject: [PATCH v3 2/9] ARM: mvebu: Limit the DMA zone when LPAE is
 selected
In-Reply-To: <1365461538-30702-3-git-send-email-gregory.clement@free-electrons.com>
References: <1365461538-30702-1-git-send-email-gregory.clement@free-electrons.com>
 <1365461538-30702-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130411180736.GM28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 12:52:10AM +0200, Gregory CLEMENT wrote:
> When LPAE is activated on Armada XP, all registers and IOs are still
> 32bit, the 40bit extension is on the CPU to DRAM path (windows) only.
> That means that all the DMA transfer are restricted to the low 32 bits
> address space. This is limitation is achieved by selecting ZONE_DMA.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/Kconfig |    1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/soc

thx,

Jason.
