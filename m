From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Aug 2015 14:36:53 +0200
Subject: [PATCH v4 2/4] gpio: brcmstb: Add interrupt and wakeup source
 support
In-Reply-To: <CADtm3G7NQqDKwGujZUA9CUJ15+e8fLg0Kupbn2CMc0MeK9DbMw@mail.gmail.com>
References: <1438391865-7862-1-git-send-email-gregory.0xf0@gmail.com>
 <1438391865-7862-3-git-send-email-gregory.0xf0@gmail.com>
 <CACRpkdaz3k_N1qS5M_jmprPz8fHXeLtTke_YT8i2gaehmme+OQ@mail.gmail.com>
 <CADtm3G7NQqDKwGujZUA9CUJ15+e8fLg0Kupbn2CMc0MeK9DbMw@mail.gmail.com>
Message-ID: <CACRpkdaTES0EtbTBUGJLfFC4-fg91Fef1CBLh5tor9SpMCo1og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 1:49 AM, Gregory Fong <gregory.0xf0@gmail.com> wrote:
> On Thu, Aug 13, 2015 at 4:11 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Sat, Aug 1, 2015 at 3:17 AM, Gregory Fong <gregory.0xf0@gmail.com> wrote:

>> This patch does not apply cleanly because the version in my
>> tree has INIT_LIST_HEAD(&priv->bank_list);
>> before the sanity check.
>>
>> I applied it manually, but check that things are working right.
>
> Your tree seems to be missing
>
> commit 2252607d327d5219a6331b50e6ec266d56402be0
> Author: Gregory Fong <gregory.0xf0@gmail.com>
> Date:   Wed Jun 17 18:00:40 2015 -0700
>
>     gpio: brcmstb: fix null ptr dereference in driver remove
>
> which you had pulled in and sent for 4.2-rc1.  It should apply cleanly
> on top of that.

Yes sorry, my bad.

I merged in v4.2-rc4 and now it looks better.

Yours,
Linus Walleij
