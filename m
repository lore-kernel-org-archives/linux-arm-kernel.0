From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Jul 2013 15:24:08 +0200
Subject: Issue with gpio and pinmux
In-Reply-To: <51F12629.7090909@parrot.com>
References: <51E667BC.3070804@parrot.com> <51E82FBB.1080905@wwwdotorg.org>
 <CACRpkdb1n07KoQZSme1EMJfV-9pHr-kd_1eJ6HsBV5gz7Dh3Ww@mail.gmail.com>
 <51EB590A.4010600@wwwdotorg.org>
 <CACRpkdZdbxEt67+YBKif4-BKAToOmN0_c8HFOdjSG91dtJwJQw@mail.gmail.com>
 <51F12629.7090909@parrot.com>
Message-ID: <CACRpkdb-hVE1Jj69ttrn+zf5cEuMHhxNh2OyhfTtrG+yUiO+jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 3:20 PM, Damien Riegel
<damien.riegel.ext@parrot.com> wrote:

> I don't know about pinctrl background but I don't really get why there
> is such a distinction between gpio and other functions in most cases.
>
> I understand that on some arch a pin can be muxed and used as a gpio at
> the same time. But on most arch, isn't gpio just another function that
> can be muxed on a pin, and therefore we should check that a pin can be
> requested as a gpio just by checking desc->mux_owner ?

Does this recently submitted documentation patch help in explaining
some of your questions?
http://marc.info/?l=linux-kernel&m=137442899829271&w=2

Yours,
Linus Walleij
