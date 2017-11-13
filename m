From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 13 Nov 2017 11:29:40 +0100
Subject: [PATCH] omap3-n900: enable autofocus
In-Reply-To: <20171112142918.rqxd2uk7ljyhpctt@earth>
References: <20171112112528.GA21009@amd>
 <20171112142918.rqxd2uk7ljyhpctt@earth>
Message-ID: <20171113102940.GC31566@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2017-11-12 15:29:18, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Nov 12, 2017 at 12:25:29PM +0100, Pavel Machek wrote:
> > 
> > Connect auto-focus coil to the camera sensor, so that it can be used
> > by camera applications.
> > 
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> I think you should replace auto-focus with lens-focus. This is not
> automatic. Otherwise:

You are right... althrough the lens is really meant for auto-focus.

Anyway, I can send the updated patch if neccessary.

Best regards,
								Pavel 
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171113/202e3be5/attachment.sig>
