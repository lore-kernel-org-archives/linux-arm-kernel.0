From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Sun, 28 Sep 2014 21:44:07 +0530
Subject: Legacy Code in gpmc-onenand.c
In-Reply-To: <5427744E.4040409@gmail.com>
References: <5427744E.4040409@gmail.com>
Message-ID: <20140928161407.GA2493@sudip-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 27, 2014 at 10:37:02PM -0400, nick wrote:
> Greetings Kevin and others,
> I am wondering if the below code is legacy I can remove it as stated it the fix me.
> Cheers Nick 
> else {
>                 /*
>                 * FIX ME: Appears to be legacy code from initial ONENAND commit.
>                 * Unclear what boards this is for and if this can be removed.
>                  */
>                 if (!cpu_is_omap34xx())
>                         onenand_sync.wait_on_read = true;
>         }

the FIX ME does not say that you can remove the code. It says you need to find out that the code is being used by which board. And if you want to remove it then you have to explain why the code is removed , and after removing what will be the effect , and if there is no effect then why there is no effect.

Good Luck.


> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
