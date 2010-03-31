From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 31 Mar 2010 09:38:24 +0300
Subject: [PATCH 0/4] HP iPAQ RX1950 patch series
In-Reply-To: <20100331011542.GN31126@trinity.fluff.org>
References: <1269109209-26237-1-git-send-email-anarsoul@gmail.com>
	<20100331011542.GN31126@trinity.fluff.org>
Message-ID: <201003310938.30403.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 31 ????? 2010 04:15:42 ????? Ben Dooks ???????:
 
> > Port still uses machine-specific GPIO API, as generic GPIO lacks GPJ
> > support and RX1950 actively uses GPJ port. However I do not see any
> > benifits in using generic GPIO API in machine support file, as it will
> > not be used with CPU different from s3c2442.
> 
> The samsung specific bits mirroring the gpio API will be removed, I will
> add post a schedule for removal notice post the next kernel merge.

Uh, but how to switch pin into function mode via gpiolib API?

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100331/a55bfb0d/attachment.sig>
