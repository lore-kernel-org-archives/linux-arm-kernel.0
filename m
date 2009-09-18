From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 18 Sep 2009 12:23:26 -0400
Subject: [PATCH] arch/arm/common/vic.c: code reorganization
In-Reply-To: <63386a3d0909180155s3032d6e7jc18b36e1b62a288f@mail.gmail.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901CBF46D@mi8nycmail19.Mi8.com>
	<63386a3d0909180155s3032d6e7jc18b36e1b62a288f@mail.gmail.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901D41EF4@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 18, 2009 1:56 AM, Linus Walleij wrote:
> 2009/9/17 H Hartley Sweeten <hartleys@visionengravers.com>:
>
>> This reorganizes the vic.c code in anticipation of a future patch
>> to use struct vic_device as the data stored in set_irq_chip_data().
>
> This doesn't apply cleanly to -next anymore, can you send an
> updated version and I'll test it?

Hmm... Applies fine to -next here.

The only thing I can think of that might keep it from applying is if
your -next tree has the patch you posted to include device.h in the
driver.  That patch is of course needed so that the file will build
but I have not seen anything about someone picking it up yet.  That
patch will fuzz mine by one line.

I was hoping your patch would get merged soon to fix the build.  I
was then planning on rebasing this patch.  I just wanted to get this
out now for any comments.

Regards,
Hartley
