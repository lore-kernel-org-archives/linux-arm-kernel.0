From: balbi@ti.com (Felipe Balbi)
Date: Wed, 15 Oct 2014 09:37:57 -0500
Subject: [PATCH 2/3] video: fbdev: omap2: omapfb: add missing
 MODULE_ALIAS()
In-Reply-To: <543E6C92.7090404@ti.com>
References: <1413311335-25083-1-git-send-email-balbi@ti.com>
 <1413311335-25083-2-git-send-email-balbi@ti.com>
 <20141014183426.GA19491@saruman> <543E6C92.7090404@ti.com>
Message-ID: <20141015143757.GB10888@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On Wed, Oct 15, 2014 at 03:46:10PM +0300, Tomi Valkeinen wrote:
> On 14/10/14 21:34, Felipe Balbi wrote:
> > On Tue, Oct 14, 2014 at 01:28:54PM -0500, Felipe Balbi wrote:
> >> without MODULE_ALIAS(), omapfb won't get loaded
> >> automatically.
> >>
> >> Signed-off-by: Felipe Balbi <balbi@ti.com>
> > 
> > little note here. This makes omapfb load automatically, but display
> > still doesn't work with DSS as modules. Backlight is working and pixel
> > clock is running just fine. Still, nothing on display.
> > 
> > I thought I'd leave that for Tomi to deal with.
> 
> I presume this is about am437x-sk. I don't have the board, so there's
> not too much I can do except send emails.
> 
> So the panel works fine if display drivers are built-in?

yup.

> The compatible string seems to be wrong in the .dts file. It says
> "osddisplays,osd057T0559-34ts" which is not the panel used. But that
> shouldn't affect this.

I got that from Darren, IIRC. Still, if it's wrong, it's wrong. What
should it be ?

> What do you mean with "pixel clock is running"?

poking at the pixel clock with a scope, I can see it clocking.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141015/ee51cf42/attachment.sig>
