From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 14 Mar 2017 16:27:26 +0200
Subject: [PATCH v2 1/4] pinctrl: samsung: Fix the width of PINCFG_TYPE_DRV
 bitfields for Exynos5433
In-Reply-To: <CACRpkda0-k7Vo9Y6yNtLNXu-gGnJW9y83t6W9p032KWjHYdMiw@mail.gmail.com>
References: <CGME20161230041426epcas1p1f827d3cee8b607d81e9921b412ddf301@epcas1p1.samsung.com>
 <20161230041421.24448-1-andi.shyti@samsung.com>
 <20161230041421.24448-2-andi.shyti@samsung.com>
 <CACRpkdbR3x14h38Gg7qpeWnswwD9qsS0zDUrrXCEJH-AdEB+cQ@mail.gmail.com>
 <58AF7CCB.5070303@samsung.com>
 <CACRpkda0-k7Vo9Y6yNtLNXu-gGnJW9y83t6W9p032KWjHYdMiw@mail.gmail.com>
Message-ID: <CAJKOXPd1pRN47Ss5qTHUVAdPwxKqE5vGGevG1OhVH0uSZnotKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 3:47 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Feb 24, 2017 at 1:22 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> On 2016? 12? 30? 22:28, Linus Walleij wrote:
>>> On Fri, Dec 30, 2016 at 5:14 AM, Andi Shyti <andi.shyti@samsung.com> wrote:
> Probably. Send a patch fixing it up so I can apply it.
>
> There are now something like 5 different people submitting Samsung pinctrl
> patches without coordination so this will start to happen a lot if you keep
> up this development pace.
>
> As I just wrote in another mail: I want someone to step up and collect
> Samsung patches and send them to me using a pull request.

I think we can handle it as there are three of us.

> Samsung people also need to start reviewing each other's patches
> more I guess, but mainly I need help with integration.

More or less recently we do the reviews. Sure we can focus more... and
actually having an entry gate for patches would ensure at least one
more review from the applying person.

Best regards,
Krzysztof
