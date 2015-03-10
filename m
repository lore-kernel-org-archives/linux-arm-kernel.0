From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 10 Mar 2015 22:41:09 +0100
Subject: [PATCH] udc: gadget: atmel_usba_udc: depend on COMMON_CLK_AT91
In-Reply-To: <20150310212353.GI25666@saruman.tx.rr.com>
References: <1425368567-5333-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150303092620.63e1861d@bbrezillon>
 <20150303094138.GC3892@piout.net>
 <20150310205312.GD18456@saruman.tx.rr.com>
 <20150310212122.GJ9188@piout.net>
 <20150310212353.GI25666@saruman.tx.rr.com>
Message-ID: <20150310214109.GL9188@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/2015 at 16:23:53 -0500, Felipe Balbi wrote :
> > Yeah, let's drop it for now but I have the feeling that this will
> > break (I actually broke it when switching at91 to multiplatform).
> 
> aha, that changes it. So you already have something which makes this
> break ? Are you planning on sending that upstream any time soon ?
> 

It has been sent but not merge and I need to send another version.

> We could very well use that same series to merge this patch. Only when
> it's needed ;-)
> 

Like said, this is not an issue for now, I fixed it by simply having all
the AT91 platform selecting COMMON_CLK_AT91. I just have the feeling
that this is not quite future proof.
So this is not urgent at all and I'll try to remember to resend when
needed.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
