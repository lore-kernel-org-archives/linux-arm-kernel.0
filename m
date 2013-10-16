From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 Oct 2013 13:35:31 +0200
Subject: [PATCH] unset twsi option3 for gconfig as well
In-Reply-To: <525C3B65.30501@gmail.com>
References: <1381706847-32762-1-git-send-email-roel.kluin@gmail.com>
 <CACRpkdb8ibOm61D_iGkOkbas1475n4k5jptnRH7VFk=9+pipHQ@mail.gmail.com>
 <20131014091230.65047d00@skate> <525C3B65.30501@gmail.com>
Message-ID: <CACRpkdbfz=SGZUt8U=u_gMmiRoCmXDv=nfR47jjzeK=wBcRxbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 8:43 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> @Linus:
> I guess the typo is there from the beginning. You know a good way to
> determine how far it should go back to -stable?

I just add CC: stable and the stable maintainers tend to figure
this out.

> Please apply with following commit msg (or request a proper v2):
>
> """
> This fixes a typo which left twsi config3 option enabled.
> """
>
> and
>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

OK patch applied and marked for stable.

Yours,
Linus Walleij
