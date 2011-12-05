From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Dec 2011 14:48:48 +0100
Subject: [PATCH] gpio: fix a build failure on KS8695 GPIO
In-Reply-To: <201112011447.31034.vapier@gentoo.org>
References: <1319741905-11051-1-git-send-email-linus.walleij@linaro.org>
 <CAJaTeTq-PrqiwqOjWgFDScm4QxHBX48Ld5h_ATknto=f69s0wQ@mail.gmail.com>
 <201112011447.31034.vapier@gentoo.org>
Message-ID: <CACRpkdbU=7=WbcjUk9o2J_nY6_atgKp8btyMytjdCbuwBXLGEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 1, 2011 at 8:47 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Thursday 27 October 2011 18:38:45 Mike Frysinger wrote:
>> thanks; both build for me after this change. ?i don't have hardware to
>> actually test, so i'll skip Tested-by and instead go for:
>> Acked-by: Mike Frysinger <vapier@gentoo.org>
>
> were you going to push this to mainline since you're now the GPIO maintainer
> while Grant is out ? :)

Yeah I missed this since it was mailed out before Grant left,
but I compensated today by sending it of directly to Torvalds.

Yours,
Linus Walleij
