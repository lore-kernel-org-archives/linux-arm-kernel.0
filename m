From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Mar 2012 15:58:41 +0000
Subject: ep93xx: convert vision_ep9307 to MULTI_IRQ_HANDLER
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F41FF55112@AUSP01VMBX24.collaborationhost.net>
References: <201203011713.59663.hartleys@visionengravers.com>
 <ADE657CA350FB648AAC2C43247A983F001F41FF55112@AUSP01VMBX24.collaborationhost.net>
Message-ID: <201203061558.41730.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 03 March 2012, H Hartley Sweeten wrote:
> On Thursday, March 01, 2012 5:14 PM, H Hartley Sweeten wrote:
> > As done for the other ep93xx machines in:
> >
> > commit 9a6879bd902e2ec605fff4d9fb3247b440a1f66a
> > ARM: ep93xx: convert to MULTI_IRQ_HANDLER
> >
> > Now that there is a generic IRQ handler for multiple VIC devices use it
> > for vision_ep9307 to help building multi platform kernels.
> >
> > Signed-off-by: Hartley Sweeten <hsweeten@visionengravers.com>
> > Acked-by: Ryan Mallon <rmallon@gmail.com>
> > Reviewed-by: Jamie Iles <jamie@jamieiles.com>
> 
> Arnd,
> 
> Could you merge this into linux-next?
> 
> It needs to go in when commit 9a6879bd902e2ec605fff4d9fb3247b440a1f66a
> is merged into mainline. Otherwise the vision_ep9307 machine will not work.

Applied to the fixes branch now, will send it out soon.

Thanks,

	Arnd
