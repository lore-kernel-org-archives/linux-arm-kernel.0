From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 4 Apr 2017 10:23:32 +0200
Subject: [GIT PULL] mfd: exynos-lpass: Pinctrl dependency
In-Reply-To: <20170403101824.rpvkqzyigonyi77p@dell>
References: <1490256207-10061-1-git-send-email-m.szyprowski@samsung.com>
 <20170328154217.5405-1-krzk@kernel.org> <20170403101824.rpvkqzyigonyi77p@dell>
Message-ID: <CAJKOXPeVOMBZxXeh7=oXbgnxSrUtHa86eAtP2BppY=G4Uygarg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 3, 2017 at 12:18 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 28 Mar 2017, Krzysztof Kozlowski wrote:
>
>>
>> Hi Lee,
>>
>>
>> This is dependency for mfd/exynos-lpass driver changes from Marek Szyprowski.
>> That's a material for v4.12 and I will be pushing this later to Linus Walleij.
>
> This does not work, and *may* still break.
>
> The only way to guarantee the order of the patches is to have them
> *all* as part of the pull-request.  Not just some of them.

What do you mean exactly? If these two patches come through my tree
first, then everything will work fine because they do not break any
other stuff.

If you pull it and apply the rest on top, then it should also work
without problems because your history will contain everything needed
in proper order.

In both cases bisectability is preserved. Did I missed something?

Best regards,
Krzysztof
