From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 Nov 2012 11:05:17 +0200
Subject: [PATCHv2 3/7] i2c: omap: remove the dtrev
In-Reply-To: <50977C80.8090000@ti.com>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-4-git-send-email-shubhrajyoti@ti.com>
 <20121105075320.GD32468@arwen.pp.htv.fi> <50977C80.8090000@ti.com>
Message-ID: <20121105090517.GB2913@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 05, 2012 at 02:14:48PM +0530, Shubhrajyoti wrote:
> On Monday 05 November 2012 01:23 PM, Felipe Balbi wrote:
> > Hi,
> >
> > On Sun, Nov 04, 2012 at 04:14:29PM +0530, Shubhrajyoti D wrote:
> >> The dtrev is used only for the comments. Remove the same and use
> >> the scheme instead to know if it is version2.
> >>
> >> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > I would drop dtrev completely and not use scheme to "emulate" it.
> However for ver2 ie omap4plus and previous versions the
> register map is different.
> 
> So the scheme may still be required.

fair enough, but drop it from debugging messages.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121105/300244f5/attachment.sig>
