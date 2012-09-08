From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sat, 8 Sep 2012 13:48:58 +0530
Subject: [PATCH] ARM: OMAP4: wakeupgen: remove duplicate AUXCOREBOOT*
 read/write
In-Reply-To: <CAMQu2gzCz+bS7U1ypFWzcp3zTpkfHdPzZfFtJ8Cd4ap8FSzJQg@mail.gmail.com>
References: <alpine.DEB.2.00.1209052333410.11516@utopia.booyaka.com>
 <CAMQu2gzCz+bS7U1ypFWzcp3zTpkfHdPzZfFtJ8Cd4ap8FSzJQg@mail.gmail.com>
Message-ID: <CAMQu2gw-KPQzYKtjJUxZjEX+_HKLL9WTxXXA35_ki8KbN+WDYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On Thu, Sep 6, 2012 at 12:05 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>
> On Thu, Sep 6, 2012 at 5:04 AM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > The wakeupgen context-save code reads and stores the AUXCOREBOOT0 and
> > AUXCOREBOOT1 register contents twice.  This seems like a waste of
> > time, so, remove the duplicates.
> >
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> Looks fine to me. Thanks Paul.
> Reviewed-by: Santosh Shilimkar ,santosh.shilimkar at ti.com>
>
> While reviewing your patch, i noticed a typo in the code.
> Since the patch fixes nearby code as the subject patch, I generated
> that patch on top of yours. Same is end of the email as well as
> attachment. The patch applies on top of your patch.
>
> Regards
> Santosh
>
> From 5fcd24e5782e502aa607b73de78be68b394f9639 Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Thu, 6 Sep 2012 11:51:34 +0530
> Subject: [PATCH] ARM: OMAP4: wakeupgen: Fix the typo in AUXCOREBOOT
> register
>  save
>
> The wakeupgen context-save code reads AUXCOREBOOT0 register
> instead of AUXCOREBOOT1 register contents while saving AUXCOREBOOT1.
>
> Fix the same.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---

Will you able to pick up these couple of wakeupgen fixes from  here or
do you want me to send you a pull request for 3.6-rc5/6

Regards
Santosh
