From: narkewoody@gmail.com (Woody Wu)
Date: Thu, 15 Nov 2012 07:40:47 +0800
Subject: Kernel uncompression error
In-Reply-To: <20121114173453.GJ3290@n2100.arm.linux.org.uk>
References: <k809hq$1q3$1@ger.gmane.org>
 <20121114173453.GJ3290@n2100.arm.linux.org.uk>
Message-ID: <CAAsE_ufXnqN09y9D43rkhk0XYkW28yAiGfwFN=6N8LGrY7s3pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012-11-15 AM1:34?"Russell King - ARM Linux" <linux@arm.linux.org.uk>
>
> On Wed, Nov 14, 2012 at 10:23:55PM +0800, woody wrote:
> > I just built a 3.2.x ARM kernel and tried to have it boot by a boot
> > loader (vivi) on my s3c2410a ARM board.  The kernel was built with
> > default configuration s3c2410.
>
> I reported that S3C2410 is totally dead with 3.x kernels about a month
> ago and got no response what so ever from anyone.  I guess S3C2410 is
> just not cared for anymore.
>
> When I get sufficient motivation, I'll try and track down what's going
> wrong, but it means taking the old mailing list server (and now list
> archive) offline for a while.
>
> I don't think it's cache related; different image sizes seem to behave
> differently - and when they _do_ successfully decompress, they don't
> boot at all.

So, in your opinion, what version of kernel I should go for s3c2410?

BTW: what people are using after days of s4c2410? I can remember it's quit
popular at then.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121115/8944a2ea/attachment-0001.html>
