From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 16 Nov 2017 15:55:38 -0800
Subject: [GIT PULL 2/3] ARM: SoC driver updates for 4.15
In-Reply-To: <CAK8P3a3uwqeeg7--UDTWJ33g7YejXp5rtV9OFt=jrt-AzQi13Q@mail.gmail.com>
References: <CAK8P3a2Wp6EANLq7JZr=uAReKOhBYrc3VKUA7FpDvq7n3Lc2aQ@mail.gmail.com>
 <CA+55aFyvWnmLzYs+Hb+d=ir9Ww8gLcNn9=Oc=zwKdK=L-nmXZA@mail.gmail.com>
 <CAK8P3a3uwqeeg7--UDTWJ33g7YejXp5rtV9OFt=jrt-AzQi13Q@mail.gmail.com>
Message-ID: <CA+55aFymY0qyc7kKHBcgx0gF7a+owFfvv+TrjV9BJAGY9k0gJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 3:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Regarding this pull request 2/3, would you prefer
>
> a) pulling it after 3/3, thereby getting a bisection problem
>     but having contents that are otherwise tested in combination

Gaah. I'll do that. You guys have been good for so long that a
one-time mistake isn't worth worrying about.

But please do make sure that your infrastructure actually checks the
branches individually in the future. Particularly since I only do the
x86-64 build, so I obviously inevitably miss a lot of potential
problems in the ARM SoC branches.

               Linus
