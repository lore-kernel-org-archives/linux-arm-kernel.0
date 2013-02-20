From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Feb 2013 18:27:22 +0200
Subject: [PATCH 1/8] ARM: OMAP5: Update SOC id detection code for ES2
In-Reply-To: <5124F3D4.1060307@ti.com>
References: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
 <1361374034-21831-2-git-send-email-santosh.shilimkar@ti.com>
 <20130220152940.GE16652@arwen.pp.htv.fi> <5124F3D4.1060307@ti.com>
Message-ID: <20130220162722.GL16652@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 20, 2013 at 09:33:32PM +0530, Santosh Shilimkar wrote:
> >>  	default:
> >>  		/* Unknown default to latest silicon rev as default*/
> >>-		omap_revision = OMAP5430_REV_ES1_0;
> >>+		omap_revision = OMAP5430_REV_ES2_0;
> >
> >how about we default to 0xffffffff ? That's the highest possible
> >version, just not sure if our revision macros can cope with it.
> >
> :D
> For record, it was decided that we will always have latest silicon
> spin as default and hence OMAP5_ES2

but then this line will forever be modified. Every year or so :-p

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130220/3e95b62d/attachment.sig>
