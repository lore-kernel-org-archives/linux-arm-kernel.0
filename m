From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 15 May 2018 08:09:23 +0200
Subject: [GIT PULL 0/5] ARM: samsung/exynos: Stuff for v4.18
In-Reply-To: <20180514205502.u25kugxkym4tz34e@localhost>
References: <20180513154238.22508-1-krzk@kernel.org>
 <20180514205502.u25kugxkym4tz34e@localhost>
Message-ID: <CAJKOXPcA-+uXof-as=5MNbHiMPBSypKmDsefDcLYVH=WhOA0ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 10:55 PM, Olof Johansson <olof@lixom.net> wrote:
> On Sun, May 13, 2018 at 05:42:33PM +0200, Krzysztof Kozlowski wrote:
>> Hi,
>>
>> Changes for v4.18. No dependencies, no specific order of pulls.
>>
>> Support for Exynos5440 is removed step by step through different trees.
>
> 5440 was always a bit of a weird fit, it clearly was never an exynos5-family
> platform. I take it there are no substantial users left that would need
> mainline kernel support for it?

I forgot to mention this in pull request (it is in the commit) - there
are no known users. There are no real products and development boards
are unpopular (probably only Samsung LSI has it).

> Also, I noticed your PGP key has expired, so you should probably start
> collecting signatures on a fresh subkey.

It should be good, I prolonged it some time ago. Can you refresh it in
your keyring?

Best regards,
Krzysztof
