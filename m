From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 22 Jul 2013 08:04:33 +0800
Subject: [PATCH 5/5] pinctrl: sirf: add freeze and restore entries for
 hibernation support
In-Reply-To: <CACRpkdY-nxceQWugtrDOkKA3atBsb2y9qfp5qEAtrK=93yaNkA@mail.gmail.com>
References: <1372924793-5579-1-git-send-email-Baohua.Song@csr.com>
 <CACRpkdY-nxceQWugtrDOkKA3atBsb2y9qfp5qEAtrK=93yaNkA@mail.gmail.com>
Message-ID: <CAGsJ_4wxJ+LVtKwajybC6ytguzpEp-Men20hrhS92xB=XdQMQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/22 Linus Walleij <linus.walleij@linaro.org>:
> On Thu, Jul 4, 2013 at 9:59 AM, Barry Song <Baohua.Song@csr.com> wrote:
>
>> this patch adds hibernation entries so that the sirf platform can
>> support suspend-to-disk.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> Are you really using this?

yes, we do for quick boot requirement.

>
> Applied anyway...
>
> Yours,
> Linus Walleij

-barry
