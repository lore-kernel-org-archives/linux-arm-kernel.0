From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Aug 2016 08:44:48 +0200
Subject: [Urgent PATCH] arm64: dts: uniphier: fix IRQ trigger type of
 ARMv8 timer
In-Reply-To: <CAK7LNAT5D0HmvpVPnX1oFw=KJSOavVjXT6ECHBuTOhNaKpdQLg@mail.gmail.com>
References: <1470039140-3801-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQo6Si9q0FQw=3i67yGO1JYuDxHBB=xsLZOj8S-TBG_Rg@mail.gmail.com>
 <CAK7LNAT5D0HmvpVPnX1oFw=KJSOavVjXT6ECHBuTOhNaKpdQLg@mail.gmail.com>
Message-ID: <4943063.JrVaCOJD4r@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, August 11, 2016 11:25:30 AM CEST Masahiro Yamada wrote:
> 2016-08-01 17:26 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:

> >>> I could do this after -rc1 is out because it is apparently a
> >>> bug fix, but in that case the for-next branch in ASOC will be
> >>> broken for me, which would make bisect-ability difficult for me.
> >>
> >> I have a patch that addresses all platforms in one go (there is really
> >> no point in fixing one at a time for a bug that is so widespread).
> >>
> >> I'll repost it later today.
> >>
> >
> > That'll be fine.
> > Thank you!
> >
> >
> > Arnd, Olof:
> > Please disregard this one.
> >
> 
> Oh Dear.
> Did you apply this one?
> 
> This was replaced with Marc'one:
> https://patchwork.kernel.org/patch/9254183/

Thanks for letting me know so quickly of my mistake, I was able
to back out the commit from the fixes branch as it was right at
the top.

	Arnd
