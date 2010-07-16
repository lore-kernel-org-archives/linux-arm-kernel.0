From: minchan.kim@gmail.com (Minchan Kim)
Date: Fri, 16 Jul 2010 09:44:29 +0900
Subject: Question of kmap_atomic
In-Reply-To: <AANLkTilFvE0eyQS7jNQ77OYkJovJugjKRO-fPHjX8CB9@mail.gmail.com>
References: <AANLkTilFvE0eyQS7jNQ77OYkJovJugjKRO-fPHjX8CB9@mail.gmail.com>
Message-ID: <AANLkTilxlwewy5YqkdCG9qFUDSv4JaJCz_cpmEWPENqp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resend with fixing the mail address.

On Fri, Jul 16, 2010 at 9:41 AM, Minchan Kim <minchan.kim@gmail.com> wrote:
> I am stuck with looking at ARM's kmap_atomic.
> I am not familiar with ARM cache model.
> As I look the code, ARM seems to have a VIPT aliasing model.
>
> Before Nicolas's 17ebba1fe, kmap_atomic always calls kmap_high_get to
> prevent aliasing problem of 7929eb9cf64 regardless of VIVT and VIPT.
>
> But the patch made it to not call kmap_high_get when VIPT-aliasing
> model in CONFIG_DEBUG_HIGHMEM.
> Doesn't it cause aliasing problem as 7929eb9cf64 says, again?
>
> --
> Kind regards,
> Minchan Kim
>



-- 
Kind regards,
Minchan Kim
