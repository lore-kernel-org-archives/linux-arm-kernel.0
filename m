From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 19:43:21 +0200
Subject: [PATCH] pinctrl/nomadik : add MC1_a_2 pin MC1 function group list
In-Reply-To: <504E2583.4070602@wwwdotorg.org>
References: <1347265874-3342-1-git-send-email-linus.walleij@stericsson.com>
 <504E2583.4070602@wwwdotorg.org>
Message-ID: <CACRpkdY5RdKDgU3_aR7G2jd2C-s=dpjsjF=0v_9zA6Ek5JpfTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 10:38 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 09/10/2012 02:31 AM, Linus Walleij wrote:
>> From: Patrice Chotard <patrice.chotard@stericsson.com>
>>
>> Another possible pin configuration for the MC1 pin group.
>
> I have no objection to this, but I wonder if these will keep trickling
> in. Is it a good idea to audit the whole driver and add everything
> that's missing in one go?

I think Patrice has most of it working and is adding the minor missing
pieces to make it perfect ... in our case the group set is driven from
usecases rather than specification, and we have a few different
boards around.

Yours,
Linus Walleij
