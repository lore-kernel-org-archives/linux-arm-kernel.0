From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Nov 2014 11:11:51 +0100
Subject: [PATCH 02/15] GPIO: port LoCoMo gpio support from old driver
In-Reply-To: <CALT56yPr42FV66USngocw=eWPt81d5R2MJxmzBnv02HOMmXAkA@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-3-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdY7tRadod2vQfEytmw-ubaMAvr_=XTczD5bUMkqie0xkg@mail.gmail.com>
 <CALT56yOgMUA7o2dzfHph=S2zkDV4zERzMh4ishpPwpAx7Cqj6Q@mail.gmail.com>
 <CACRpkdb7v3LmOhbhQ9TPk1_bnLnpwizawW6RQvhQRLSjRewAaQ@mail.gmail.com>
 <CALT56yO9f8wzaArnmfQSDzCM3S+2oT+62anH5kbFY3WdEt_HZg@mail.gmail.com>
 <20141106060335.GR8509@sirena.org.uk>
 <CALT56yPr42FV66USngocw=eWPt81d5R2MJxmzBnv02HOMmXAkA@mail.gmail.com>
Message-ID: <CACRpkdZiari6CtWq1kBCvX3cwwatJiHAuWUb40WSUEfjZjk+Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 2:16 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> Just to better understand your suggestions: do you want me to convert
> to regmap only gpio driver or do you suggest to convert all LoCoMo drivers?

Um... I was just thinking about this one usecase.

It's no big deal, the other review comments are more important.

> That is doable, of course, but the amount of changes is overwhelming.
> Also I'm concerned about the performance impact from going through
> regmap layers.

Is it on a critical path? The current locking isn't any less invasive
AFAICT.

Yours,
Linus Walleij
