From: balbi@ti.com (Felipe Balbi)
Date: Fri, 7 Sep 2012 20:23:58 +0300
Subject: [PATCH] ARM: dts: OMAP4: Add reg and interrupts for every nodes
In-Reply-To: <504A11E4.6000406@ti.com>
References: <504A11E4.6000406@ti.com>
Message-ID: <20120907172355.GA9208@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 07, 2012 at 05:25:24PM +0200, Benoit Cousson wrote:
> Thanks to Vaibhav <hvaibhav@ti.com> omap_device fix
> (ARM: OMAP: omap_device: Fix up resource names when booted with devicetre),
> we can now specify reg and interrupts using standard device tree
> attributes.
> 
> Update the OMAP4 dtsi file with missing reg and interrupts attributes.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Felipe Balbi <balbi@ti.com>
> ---
> 
> Hi Tony,
> 
> This is the first step toward reduction of the hwmod data inside mach-omap2.
> OMAP2/3/4 data still need to be there for legacy boards, but it will allow
> OMAP5/AM33XX pure DT board to reduce the amount of data provided by hwmod.
> 
> DMA is still missing, but I hope that the discussion that happened during
> LPC will fixed that soon.

Very nice work. Do you already have a way on omap_device creation to use
DT data instead of hwmod's ?

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120907/71a6856d/attachment.sig>
