From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 15 Apr 2010 00:42:07 +0200
Subject: [PATCH] pxa: make it clear by converting MMC 'delay_detect' to
	millisecond
In-Reply-To: <i2lf17812d71004131608tef462c28u861748959c308c97@mail.gmail.com>
References: <i2lf17812d71004131608tef462c28u861748959c308c97@mail.gmail.com>
Message-ID: <201004150042.07772.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 14. dubna 2010 01:08:13 Eric Miao napsal(a):
> commit 4db1d6645934f49806bd1b49ae4c4176e9b7c843
> Author: Eric Miao <eric.y.miao@gmail.com>
> Date:   Wed Apr 14 07:00:42 2010 +0800
> 
>     [ARM] pxa: make it clear by converting MMC 'delay_detect' to
> millisecond
> 
>     delay_detect in HZ is confusing, convert it to be millisecond based.
> And thus remove those unnecessary call to msecs_to_jiffies() at runtime
> for this field. Other constants are converted assuming HZ == 100, which
> are basically true for those platforms.
> 
>     The assignment in csb726.c was incorrect, and is fixed in this patch as
>     a result.
> 
>     Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> 

For Palm*, Voipac270 and ZipitZ2:

Acked-by: Marek Vasut <marek.vasut@gmail.com>
