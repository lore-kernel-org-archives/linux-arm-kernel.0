From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 12 Apr 2010 22:38:11 +0300
Subject: [PATCH 0/4] HP iPAQ RX1950 patch series
In-Reply-To: <20100331011542.GN31126@trinity.fluff.org>
References: <1269109209-26237-1-git-send-email-anarsoul@gmail.com>
	<20100331011542.GN31126@trinity.fluff.org>
Message-ID: <201004122238.16744.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 31 ????? 2010 04:15:42 ????? Ben Dooks ???????:
> On Sat, Mar 20, 2010 at 08:20:05PM +0200, Vasily Khoruzhick wrote:
> > Following patch series add support for iPAQ RX1950 PDA - another
> > s3c2442-based machine.
> > Almost all drivers for this machine are included in mainline kernel, and
> > port only lacks battery, WiFi and sound support, they will be added
> > later.
> > 
> > Port still uses machine-specific GPIO API, as generic GPIO lacks GPJ
> > support and RX1950 actively uses GPJ port. However I do not see any
> > benifits in using generic GPIO API in machine support file, as it will
> > not be used with CPU different from s3c2442.
> 
> The samsung specific bits mirroring the gpio API will be removed, I will
> add post a schedule for removal notice post the next kernel merge.
> 
> > Denis: I hope you'll add your Signed-off at least under first patch.
> > 
> > I doubt that I can get Signed-off from Victor Chukhantsev, as he doesn't
> > work on port for a long time.
> 
> The patches look ok. I'm not sure if someone else can vouch for Victor's
> approval, or authenticty of patches. However if the main authours are
> willing to authenticate the code, then I'll accept this unless someone
> else objects.

Hi, Ben

What modifications are neccessary for these patches to get them into your 
tree?
I can resend patch series if you want.

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100412/bb3f6354/attachment.sig>
