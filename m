From: narkewoody@gmail.com (woody)
Date: Thu, 15 Nov 2012 13:56:47 +0800
Subject: Kernel uncompression error
In-Reply-To: <20121114173453.GJ3290@n2100.arm.linux.org.uk>
References: <k809hq$1q3$1@ger.gmane.org>
 <20121114173453.GJ3290@n2100.arm.linux.org.uk>
Message-ID: <50A4841F.9070507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2012 1:34 AM, Russell King - ARM Linux wrote:
> On Wed, Nov 14, 2012 at 10:23:55PM +0800, woody wrote:
>> I just built a 3.2.x ARM kernel and tried to have it boot by a boot
>> loader (vivi) on my s3c2410a ARM board.  The kernel was built with
>> default configuration s3c2410.
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

Now I switched from 3.2.x kernel to the latest stable 3.6.6. And, I did 
a lot of configuration to make the zImage size smaller, now it is 1.5M. 
After download it to the board, I got another error:

"Uncompressing Linux... done, booting the kernel."

Then the kernel halted.

I noticed, the dots (...) in the kernel log seems very short, is this a 
clue or just normal?



-- 
woody
I can't go back to yesterday - because I was a different person then.
