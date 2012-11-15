From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Nov 2012 11:31:50 +0000
Subject: Kernel uncompression error
In-Reply-To: <CA+E=qVdDGszU1jMDXjFepvnSmiRTWJ=A_23BL2LEty+170FNsA@mail.gmail.com>
References: <k809hq$1q3$1@ger.gmane.org>
 <20121114173453.GJ3290@n2100.arm.linux.org.uk>
 <CA+E=qVdDGszU1jMDXjFepvnSmiRTWJ=A_23BL2LEty+170FNsA@mail.gmail.com>
Message-ID: <20121115113150.GO3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 02:29:40PM +0300, Vasily Khoruzhick wrote:
> On Wed, Nov 14, 2012 at 8:34 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Nov 14, 2012 at 10:23:55PM +0800, woody wrote:
> >> I just built a 3.2.x ARM kernel and tried to have it boot by a boot
> >> loader (vivi) on my s3c2410a ARM board.  The kernel was built with
> >> default configuration s3c2410.
> >
> > I reported that S3C2410 is totally dead with 3.x kernels about a month
> > ago and got no response what so ever from anyone.  I guess S3C2410 is
> > just not cared for anymore.
> 
> It was working at least for 3.1 (tested on h1940 machine),
> can you give a link to your post? I still care about s3c2410 and s3c244x :)

Subject: s3c2410 bast (== lists.arm.linux.org.uk) - appears to be broken
        with 3.1.8...
