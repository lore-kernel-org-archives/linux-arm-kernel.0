From: narkewoody@gmail.com (Woody Wu)
Date: Wed, 21 Nov 2012 01:34:20 +0000 (UTC)
Subject: Kernel uncompression error
References: <k809hq$1q3$1@ger.gmane.org>
 <20121114173453.GJ3290@n2100.arm.linux.org.uk>
 <CAAsE_ufdjZN31BXWTcq5XyRhx5YcoECRJVvARcNh8qT-AP1_jw@mail.gmail.com>
 <20121115093357.GN3290@n2100.arm.linux.org.uk>
Message-ID: <slrnkaobra.2jk.narkewoody@zuhnb712.local.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-15, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Thu, Nov 15, 2012 at 07:35:30AM +0800, Woody Wu wrote:
>> > On Wed, Nov 14, 2012 at 10:23:55PM +0800, woody wrote:
>> > > I just built a 3.2.x ARM kernel and tried to have it boot by a boot
>> > > loader (vivi) on my s3c2410a ARM board.  The kernel was built with
>> > > default configuration s3c2410.
>> >
>> > I reported that S3C2410 is totally dead with 3.x kernels about a month
>> > ago and got no response what so ever from anyone.  I guess S3C2410 is
>> > just not cared for anymore.
>> >
>> > When I get sufficient motivation, I'll try and track down what's going
>> > wrong, but it means taking the old mailing list server (and now list
>> > archive) offline for a while.
>> >
>> > I don't think it's cache related; different image sizes seem to behave
>> > differently - and when they _do_ successfully decompress, they don't
>> > boot at all.
>> 
>> So, in your opinion, what version of kernel I should go for s3c2410?
>
> lists.arm.linux.org.uk currently runs 2.6.32.8.  That's the last working
> kernel I currently know of.
>
> As I said, I tried several 3.x kernels, all of them failed.
>

I just found 3.4.19 works.

-- 
woody
I can't go back to yesterday - because I was a different person then.
