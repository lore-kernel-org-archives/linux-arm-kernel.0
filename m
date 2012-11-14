From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Nov 2012 17:34:53 +0000
Subject: Kernel uncompression error
In-Reply-To: <k809hq$1q3$1@ger.gmane.org>
References: <k809hq$1q3$1@ger.gmane.org>
Message-ID: <20121114173453.GJ3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 10:23:55PM +0800, woody wrote:
> I just built a 3.2.x ARM kernel and tried to have it boot by a boot  
> loader (vivi) on my s3c2410a ARM board.  The kernel was built with  
> default configuration s3c2410.

I reported that S3C2410 is totally dead with 3.x kernels about a month
ago and got no response what so ever from anyone.  I guess S3C2410 is
just not cared for anymore.

When I get sufficient motivation, I'll try and track down what's going
wrong, but it means taking the old mailing list server (and now list
archive) offline for a while.

I don't think it's cache related; different image sizes seem to behave
differently - and when they _do_ successfully decompress, they don't
boot at all.
