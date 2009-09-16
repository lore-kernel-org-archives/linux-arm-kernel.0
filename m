From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Wed, 16 Sep 2009 23:46:56 +0200
Subject: Samsung S3C6410 / SmartQ / 2D acceleration / Xorgy
In-Reply-To: <mailman.1668.1253069003.2256.linux-arm-kernel@lists.infradead.org>
References: <mailman.1668.1253069003.2256.linux-arm-kernel@lists.infradead.org>
Message-ID: <4AB15CD0.2050104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Op 16-09-09 04:43, linux-arm-kernel-request at lists.infradead.org schreef:
> I am not sure about uio.  Sorry.
>
> The main problem is the g2d fifo is 32 commands deep.  And some of the
> x11perf tests are running in our XAA s3c driver @ ~2e6 ops/sec.  That is is
> lot of interrupts for user or kernel context.:-)
>
> Sometimes polling is better.  1/2:-)
>
> We are 1 stupid bug away from a release of s3c Xwindows fbdev + XAA +
> Xvideo (using the samsung s3c-pp) and HW cursor with alpha blend.
>    

This sounds great!

Do you have any code available?

Regards,
Maurus Cuelenaere
