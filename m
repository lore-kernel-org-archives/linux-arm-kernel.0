From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 14 Apr 2010 19:27:27 +0200
Subject: [PATCH] pxa: make it clear by converting MMC 'delay_detect' to
	millisecond
In-Reply-To: <i2lf17812d71004131608tef462c28u861748959c308c97@mail.gmail.com>
	(Eric Miao's message of "Wed, 14 Apr 2010 07:08:13 +0800")
References: <i2lf17812d71004131608tef462c28u861748959c308c97@mail.gmail.com>
Message-ID: <87hbne7xmo.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao <eric.y.miao@gmail.com> writes:

> commit 4db1d6645934f49806bd1b49ae4c4176e9b7c843
> Author: Eric Miao <eric.y.miao@gmail.com>
> Date:   Wed Apr 14 07:00:42 2010 +0800
>
>     [ARM] pxa: make it clear by converting MMC 'delay_detect' to millisecond
>
>     delay_detect in HZ is confusing, convert it to be millisecond based. And
>     thus remove those unnecessary call to msecs_to_jiffies() at runtime for
>     this field. Other constants are converted assuming HZ == 100, which are
>     basically true for those platforms.
>
>     The assignment in csb726.c was incorrect, and is fixed in this patch as
>     a result.
>
>     Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

For mioa701 part, please find my :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

--
Robert
