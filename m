From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Nov 2016 10:34:14 +0100
Subject: [PATCH v2 1/6] pinctrl-aspeed-g5: Never set SCU90[6]
In-Reply-To: <CACPK8Xcbv5VjE9deETV6zC4cPSfeBSgP96QYqV_ebAgtB9Jwtw@mail.gmail.com>
References: <1478097481-14895-1-git-send-email-andrew@aj.id.au>
 <1478097481-14895-2-git-send-email-andrew@aj.id.au>
 <CACPK8Xcbv5VjE9deETV6zC4cPSfeBSgP96QYqV_ebAgtB9Jwtw@mail.gmail.com>
Message-ID: <CACRpkdbH8eubEHwHCsdJsmqVp3hkBW4vb5DCHvJxz+tyfFqbKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 3, 2016 at 11:59 PM, Joel Stanley <joel@jms.id.au> wrote:

> In the future I think we should send fixes separately from the rest of
> the series, so it's clear to Linus where we expect patches to end up.
>
> Perhaps Linus can share his preference with us?

Just make it clear to me where the patch is headed, if it is
a fix or a new feature.

Also mixing stuff in big series is of course problematic because
all the CC:in on MFD patches and whatnot that I don't apply
makes the picture blurry, but sometimes it is anyways needed
for context so it is a soft requirement.

Yours,
Linus Walleij
