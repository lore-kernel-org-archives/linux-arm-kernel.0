From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 15 Nov 2012 14:29:40 +0300
Subject: Kernel uncompression error
In-Reply-To: <20121114173453.GJ3290@n2100.arm.linux.org.uk>
References: <k809hq$1q3$1@ger.gmane.org>
 <20121114173453.GJ3290@n2100.arm.linux.org.uk>
Message-ID: <CA+E=qVdDGszU1jMDXjFepvnSmiRTWJ=A_23BL2LEty+170FNsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 8:34 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Nov 14, 2012 at 10:23:55PM +0800, woody wrote:
>> I just built a 3.2.x ARM kernel and tried to have it boot by a boot
>> loader (vivi) on my s3c2410a ARM board.  The kernel was built with
>> default configuration s3c2410.
>
> I reported that S3C2410 is totally dead with 3.x kernels about a month
> ago and got no response what so ever from anyone.  I guess S3C2410 is
> just not cared for anymore.

It was working at least for 3.1 (tested on h1940 machine),
can you give a link to your post? I still care about s3c2410 and s3c244x :)

> When I get sufficient motivation, I'll try and track down what's going
> wrong, but it means taking the old mailing list server (and now list
> archive) offline for a while.
>
> I don't think it's cache related; different image sizes seem to behave
> differently - and when they _do_ successfully decompress, they don't
> boot at all.

Regards
Vasily
