From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 6 Jan 2012 21:31:42 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
In-Reply-To: <20120106084841.GJ11810@n2100.arm.linux.org.uk>
References: <20120106120317.500c45afe95ae20b4b6648a0@canb.auug.org.au>
 <20120106084841.GJ11810@n2100.arm.linux.org.uk>
Message-ID: <20120106213142.bef2d9b63e09eb42234e2b01@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, 6 Jan 2012 08:48:41 +0000 Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>
> On Fri, Jan 06, 2012 at 12:03:17PM +1100, Stephen Rothwell wrote:
> > 
> > Today's linux-next merge of the arm-soc tree got a conflict in
> > arch/arm/mach-omap2/pm34xx.c between commit e6ab10af962d ("ARM: OMAP:
> > convert idle handlers from pm_idle to arm_pm_idle") from the arm tree and
> > commit 2fd149645eb4 ("") from the arm-soc tree.
> 
> Err, there's an empty description of a commit in the arm-soc tree?

Sorry about that:

ARM: OMAP2+: UART: Remove omap_uart_can_sleep and add pm_qos

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120106/c5670f13/attachment.sig>
