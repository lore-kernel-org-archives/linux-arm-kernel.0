From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Jul 2010 10:35:21 +0100
Subject: Problem with dma_alloc_coherent at linux-2.6.33-arm1 , with
	RealView platform,board PBX-A9 and armv7 instructions.
In-Reply-To: <AANLkTimtpIQaKVHidWP9fvOKGGiQRc0tne1kO5mO-Zzs@mail.gmail.com>
References: <AANLkTimtpIQaKVHidWP9fvOKGGiQRc0tne1kO5mO-Zzs@mail.gmail.com>
Message-ID: <20100715093521.GD26212@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 05:13:57PM +0800, David Yang wrote:
>        But when the driver was ported to the linux-2.6.33-arm1,the problem
> came:
>                 I found when the cpu executed from step 1-3, the
> device DMA alarm the
> step 2 was not completed.As a result,the step 4 was not triggered.This
> is different form linux-2.6.28.

Can you try patches 6219/1 6220/1 and 6221/1 from the patch system?
They can be viewed/downloaded via:

http://www.arm.linux.org.uk/developer/patches/view.php?id=6219/1
http://www.arm.linux.org.uk/developer/patches/view.php?id=6220/1
http://www.arm.linux.org.uk/developer/patches/view.php?id=6221/1

Thanks.
