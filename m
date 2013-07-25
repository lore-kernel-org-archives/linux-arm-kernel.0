From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Jul 2013 17:06:05 +0200
Subject: Issue with gpio and pinmux
In-Reply-To: <51F13973.70806@parrot.com>
References: <51E667BC.3070804@parrot.com> <51E82FBB.1080905@wwwdotorg.org>
 <CACRpkdb1n07KoQZSme1EMJfV-9pHr-kd_1eJ6HsBV5gz7Dh3Ww@mail.gmail.com>
 <51EB590A.4010600@wwwdotorg.org>
 <CACRpkdZdbxEt67+YBKif4-BKAToOmN0_c8HFOdjSG91dtJwJQw@mail.gmail.com>
 <51F12629.7090909@parrot.com>
 <CACRpkdb-hVE1Jj69ttrn+zf5cEuMHhxNh2OyhfTtrG+yUiO+jg@mail.gmail.com>
 <51F13973.70806@parrot.com>
Message-ID: <CACRpkdaxD9ShfciD2CJY-1X9hmRPFj+mnFxJXp7ddA0PAZh4wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 4:42 PM, Damien Riegel
<damien.riegel.ext@parrot.com> wrote:

> My reflection rather was: when gpio is not orthogonal, we could just
> check mux_owner to see if pin is available; and when it is, use the
> current implementation.
>
> But well, we obviously need to way to tell if gpios are orthogonal or
> not, and adding a function to struct pinmux_ops is an elegant solution
> to do so since it even allows a pin granularity.

Yep, I'm just waiting for the patches now :-)

Yours,
Linus Walleij
