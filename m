From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Jan 2014 15:01:05 +0100
Subject: Boot time errors/warnings on snowball
In-Reply-To: <20131217144756.GJ19810@lee--X1>
References: <CAOesGMgwyU-fJWkiF+78US+vVZ7Ensku-j+O1UPFVt43WDfUsA@mail.gmail.com>
 <CACRpkda3V4bK3_QO76=++Gcm3pJp78G2L3pgAdaJb2NDcAJG6Q@mail.gmail.com>
 <20131204172626.GB26581@lee--X1>
 <CAOesGMjMWqPtJXh7-VAhyA1a95h7mKV8_UZhyTtxgEbUhU8_5Q@mail.gmail.com>
 <20131204175119.GD26581@lee--X1>
 <CAOesGMh7+r9vUvtH_pwJeMyQJGo3u-uJRJ8-OBidzzO1pC5RDA@mail.gmail.com>
 <20131204185947.GC29268@sirena.org.uk>
 <20131205094927.GJ26581@lee--X1> <20131217144756.GJ19810@lee--X1>
Message-ID: <CACRpkdaEV83oq+mUYsR=rzNhzXWrQXAWWdZDNhzurC_iVGPPKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 3:47 PM, Lee Jones <lee.jones@linaro.org> wrote:
> Original comment from Olof:

>> > Done - the whole thing with the MMC is very weird.
>
> Right, and was actually unrelated. -next still has this issue. Sadly
> this will have to be looked at by someone other than myself, as I have
> far too much on at the moment.
>
> Linus, can you ask Ulf to have a look at this please?

I think I have some MMC-related patches from Ulf in my tree
queued up, I'll send a pull request for these on top of previous
device tree patches so you can check of that solves the issues.

Yours,
Linus Walleij
