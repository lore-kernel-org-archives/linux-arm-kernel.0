From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 3 Jun 2010 13:47:00 +0800
Subject: Query about arch/arm/boot/compressed/Makefile.debug
In-Reply-To: <198ace.57aa.128fc51e27e.Coremail.bill_carson@126.com>
References: <198ace.57aa.128fc51e27e.Coremail.bill_carson@126.com>
Message-ID: <AANLkTinEA_7sFG9WqzETirCY76XIIeicKe3Cw9eQvYwx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 3, 2010 at 1:39 PM, rocky <bill_carson@126.com> wrote:
> Hi, all
> I'm porting Linux to a ARM1176 based SOC, sometimes after running make zImage,
> I got CRC error when uncompressing the kernel all the time.

Conduct a strict memory checking and check the cache enabling code, normally
that's where the problem is. The decompressor itself, should be less problematic
since it's working elsewhere on most other platforms.

>
> no idea why this should happened, i want to use misc.c with STANDALONE_DEBUG mode,
> so how should i use this debug mode?
>
>
> thanks
> BR
> rocky
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
