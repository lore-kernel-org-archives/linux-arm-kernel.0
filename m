From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:40:10 +0800
Subject: [PATCH 08/22] regulator: Change ab8500 match names to reflect
 Device Tree
In-Reply-To: <CACRpkdbQv8Q07iRAmG3UQRm7UNDi_Y+s_vvACDKKxR9tg+1iqg@mail.gmail.com>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdbQv8Q07iRAmG3UQRm7UNDi_Y+s_vvACDKKxR9tg+1iqg@mail.gmail.com>
Message-ID: <CACRpkdbFgwF+rYthawxn8mW90u_BP0c+h=GODwQk5VwTF+JdqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 2:58 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, May 30, 2012 at 12:47 PM, Lee Jones <lee.jones@linaro.org> wrote:
>
>> The 'name' field in 'struct of_regulator_match' expects to match with
>> its corresponding regulator device node in the Device Tree. This patch
>> renames each of the regulators in the ab8500 regulator driver so this
>> is true.
>
> Anyway: the name is used in more parts of the file, so please change
> it everywhere if you change it.

I was wrong on this, ignore that comment. I understand this now...
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
