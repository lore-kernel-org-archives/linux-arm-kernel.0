From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 4 Jul 2017 14:46:38 -0700
Subject: [GIT PULL 4/7] ARM: SoC defconfig updates
In-Reply-To: <CAK8P3a0z-Z+5N=PvY105-B+8=JY4eeR_=s3PJMQcffTZzcBhRw@mail.gmail.com>
References: <CAK8P3a0z-Z+5N=PvY105-B+8=JY4eeR_=s3PJMQcffTZzcBhRw@mail.gmail.com>
Message-ID: <CA+55aFxR3BpZvyVGWeAh8a7d0J90FOC5Yw1GbWrtH1M+kA1Pqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 4, 2017 at 7:23 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Aside from that, there is the usual driver enablement, this time for
> davinci, samsung, stm?2, bcm2835, qualcomm, at91, imx, mvebu, and omap.

"stm?2"?

That's a very cool character, but I'm sadly assuming that it's just a
typo, and you were talking about stm32.

And if it really was intentional, I'm sorry for having corrected it in
the merge commit ;(

              Linus
