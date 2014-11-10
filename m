From: balbi@ti.com (Felipe Balbi)
Date: Mon, 10 Nov 2014 17:37:14 -0600
Subject: [PATCH] arm: boot: dts: dra7: add labels to DWC3 nodes
In-Reply-To: <20141110232709.GB31454@atomide.com>
References: <1415032122-8230-1-git-send-email-balbi@ti.com>
 <20141110232709.GB31454@atomide.com>
Message-ID: <20141110233714.GQ1041@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 03:27:09PM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [141103 08:30]:
> > by adding labels to DWC3 nodes, it's far easier
> > for boards to reference them.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> 
> Applying into omap-for-v3.19/dt, had to update it because
> of "ARM: dts: DRA7: Move USB_OTG 4 to dra74x.dtsi". Updated
> patch below.
> 
> Regards,
> 
> Tony
> 
> 8< -------------------
> From: Felipe Balbi <balbi@ti.com>
> Date: Mon, 3 Nov 2014 10:28:42 -0600
> Subject: [PATCH] arm: boot: dts: dra7: add labels to DWC3 nodes
> 
> by adding labels to DWC3 nodes, it's far easier
> for boards to reference them.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> [tony at atomide.com: updated for otg 4 move to dra74x.dtsi]
> Signed-off-by: Tony Lindgren <tony@atomide.com>

looks good, thanks.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141110/698df04f/attachment.sig>
