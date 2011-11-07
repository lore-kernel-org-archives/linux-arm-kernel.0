From: balbi@ti.com (Felipe Balbi)
Date: Mon, 7 Nov 2011 21:39:09 +0200
Subject: [PATCH] arm: omap2+: hwmod: fix breakage introduced by d6504acd
In-Reply-To: <20111107183208.GG15294@n2100.arm.linux.org.uk>
References: <1320688617-4543-1-git-send-email-balbi@ti.com>
 <20111107183208.GG15294@n2100.arm.linux.org.uk>
Message-ID: <20111107193908.GA5059@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 07, 2011 at 06:32:08PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 07, 2011 at 07:56:57PM +0200, Felipe Balbi wrote:
> > commit d6504acd (OMAP2+: hwmod: remove OMAP_CHIP*) has
> > mistakenly added MUSB as a hwmod available only on ES2.0
> > of OMAP3430.
> > 
> > MUSB hwmod has always be available on all OMAP revisions
> > since OMAP2430.
> 
> This doesn't seem to solve it:

then i can't help. From all I know the LDP is based on OMAP3430 so that
should work. If it doesn't, it's something deeper on hwmod, maybe ?

Paul, it's your call.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111107/4eff924f/attachment.sig>
