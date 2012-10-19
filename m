From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Oct 2012 11:58:15 +0200
Subject: [PATCH] gpio: clps711x: localise <mach/gpio.h> header
In-Reply-To: <20121016004741.485430a1c243795488fbc69b@mail.ru>
References: <1350330020-23240-1-git-send-email-linus.walleij@linaro.org>
 <20121016000405.94f779c6066ded6289e35baa@mail.ru>
 <CACRpkdYxQsS4RfCxk3E4GPa+7GK2FeOVfTCps1ZtPC=gSw2a0g@mail.gmail.com>
 <20121016004741.485430a1c243795488fbc69b@mail.ru>
Message-ID: <CACRpkdboiOh7xVY7iLPso8RNrJ9kThwE9HfKdwLhCHykqukChQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 10:47 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
>> We don't want to add new files to <mach/*>.
> OK, but since it will be used only in board code, I reintroduce it
> in arch/arm/mach-clps711x/common.h. On my opinion is no reason to
> overload include/linux/*.

Sure. That's even better.

Yours,
Linus Walleij
