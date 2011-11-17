From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 17 Nov 2011 11:32:40 +0100
Subject: [PATCH 0/3] make stmp-style devices mach-independent
In-Reply-To: <20111117014946.GE14656@S2100-06.ap.freescale.net>
References: <1321440459-4527-1-git-send-email-w.sang@pengutronix.de>
 <20111117014946.GE14656@S2100-06.ap.freescale.net>
Message-ID: <20111117103240.GE2535@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Right thing to do?
> 
> I think it's the right thing to do.  But I do not like the name as
> stmp-style device.  Why not just mxs-style device?  Name mxs is born
> to replace stmp, and keeping using two names may confuse people.

I chose it because it was the first platform where I saw this kind of
layout. I don't like it too much as well, but couldn't find any better.
What I liked about it being different to 'mxs' is that you could easily
grep which drivers still need to be converted :) I am also not sure if
it is less confusing if you have mxs-style devices (compared to
stmp-style devices) on, say, MX6. Something platform-independent would
be cool...

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111117/e6f443f0/attachment.sig>
