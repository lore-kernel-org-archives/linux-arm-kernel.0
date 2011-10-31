From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 31 Oct 2011 16:50:37 +0100
Subject: [PATCH] ARM: mark empty gpio.h files empty
In-Reply-To: <20111029110613.GE20132@ponder.secretlab.ca>
References: <1319833142-4764-1-git-send-email-linus.walleij@linaro.org>
	<20111029110613.GE20132@ponder.secretlab.ca>
Message-ID: <CACRpkdaVWSG+it=pJhYeS043ocsogbG+rC+nxR0grgeGfgfFjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 29, 2011 at 1:06 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Fri, Oct 28, 2011 at 10:19:02PM +0200, Linus Walleij wrote:
>> It is generally a better idea to make intentionally empty files
>> contain the human-readable /* empty */ comment, also it makes
>> the files play nice with "make distclean".
>>
>> Reported-by: Jeff Garzik <jeff@garzik.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Applied, thanks.

Hm I put that into Russell's patch tracker since it was mainly
touching arch/arm/*
and I think he applied it too.

Well whatever, git will cope.

Yours,
Linus Walleij
