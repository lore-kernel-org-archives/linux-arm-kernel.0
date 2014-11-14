From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 14 Nov 2014 16:48:12 +0400
Subject: [PATCH 02/15] GPIO: port LoCoMo gpio support from old driver
In-Reply-To: <CACRpkdZiari6CtWq1kBCvX3cwwatJiHAuWUb40WSUEfjZjk+Lg@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-3-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdY7tRadod2vQfEytmw-ubaMAvr_=XTczD5bUMkqie0xkg@mail.gmail.com>
 <CALT56yOgMUA7o2dzfHph=S2zkDV4zERzMh4ishpPwpAx7Cqj6Q@mail.gmail.com>
 <CACRpkdb7v3LmOhbhQ9TPk1_bnLnpwizawW6RQvhQRLSjRewAaQ@mail.gmail.com>
 <CALT56yO9f8wzaArnmfQSDzCM3S+2oT+62anH5kbFY3WdEt_HZg@mail.gmail.com>
 <20141106060335.GR8509@sirena.org.uk>
 <CALT56yPr42FV66USngocw=eWPt81d5R2MJxmzBnv02HOMmXAkA@mail.gmail.com>
 <CACRpkdZiari6CtWq1kBCvX3cwwatJiHAuWUb40WSUEfjZjk+Lg@mail.gmail.com>
Message-ID: <CALT56yNh=orC+-iq--6MJv5swc_EjgG=n=0zJf-css8jdWGVFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-14 13:11 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Nov 11, 2014 at 2:16 PM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>
>> Just to better understand your suggestions: do you want me to convert
>> to regmap only gpio driver or do you suggest to convert all LoCoMo drivers?
>
> Um... I was just thinking about this one usecase.

I ended up converting all drivers. It allowed me to clean up several points
in the driver.

>
> It's no big deal, the other review comments are more important.

Fixed most of the comments. Last remaining issue is factoring out m62332
interface.

>> That is doable, of course, but the amount of changes is overwhelming.
>> Also I'm concerned about the performance impact from going through
>> regmap layers.
>
> Is it on a critical path? The current locking isn't any less invasive
> AFAICT.
>
> Yours,
> Linus Walleij



-- 
With best wishes
Dmitry
