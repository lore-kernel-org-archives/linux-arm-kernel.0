From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 29 Sep 2015 22:39:05 +0200
Subject: [PATCH 0/4] memory: pl17x: add support of PL175 and PL176
 controllers
In-Reply-To: <1443459043-24144-1-git-send-email-vz@mleia.com>
References: <1443459043-24144-1-git-send-email-vz@mleia.com>
Message-ID: <CAGhQ9VzUwkkXqRQ-WZ_cjRKCrE=co1LNwFaQfGmBbuEOsVZ6_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On 28 September 2015 at 18:50, Vladimir Zapolskiy <vz@mleia.com> wrote:
> The change adds support of ARM PrimeCell PL175 MPMC and PL176 MPMC,
> the static memory controllers on devices are similar to one found on
> ARM PrimeCell PL172, add support to the existing driver.
>
> Vladimir Zapolskiy (4):
>   memory: pl172: correct MPMC peripheral ID register bits
>   memory: pl172: add ARM PrimeCell PL175 MPMC support
>   memory: pl172: add ARM PrimeCell PL176 MPMC support
>   doc: dt: arm,pl172: add description of PL175 and PL176 controllers

Changes look good to me.

What LPC32xx board did you test this on, btw?

Also if you have added the controller to lpc32xx.dtsi it would be
great if you could also submit those changes to the lpc32xx
maintainer.


regards,
Joachim Eastwood
