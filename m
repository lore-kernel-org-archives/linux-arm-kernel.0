From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Sep 2013 11:16:10 +0200
Subject: [PATCH] ARM: multi_v7: add HREFv60 to multi_v7 defconfig
In-Reply-To: <20130916145418.GA7221@quad.lixom.net>
References: <1379334152-9751-1-git-send-email-linus.walleij@linaro.org>
 <20130916145418.GA7221@quad.lixom.net>
Message-ID: <CACRpkdbsgAp_7NTOQNpD+TvEdkT6L4K9o5RwAArUGE9B6hunjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 16, 2013 at 4:54 PM, Olof Johansson <olof@lixom.net> wrote:
> On Mon, Sep 16, 2013 at 02:22:32PM +0200, Linus Walleij wrote:
>> This is just a standard board for the Ux500, include it in the
>> v7 multiplatform defconfig.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Hi ARM SoC folks: this makes also my preferred development board
>> boot with multi_v7. Please apply this patch directly to fixes
>> if you're happy with it.
>
> Ho hum. I think the approach we want is to only do DT platforms on
> multi_v7.  You have a series to drop/switch all non-DT platforms coming
> soon though, I think?

Yes and yes. But the patch was intended for the v3.12-rcs to be
usable.

Yours,
Linus Walleij
