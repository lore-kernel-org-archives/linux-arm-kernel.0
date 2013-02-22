From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 22 Feb 2013 14:29:32 +0000
Subject: [PATCH] arm64: select ARCH_WANT_OPTIONAL_GPIOLIB
In-Reply-To: <CACRpkdat0Z9vAc9YB0T9s+Cex6FbyHnT_Nj0OV3FLnQbexZqwg@mail.gmail.com>
References: <20130218111410.GA10572@e106331-lin.cambridge.arm.com>
 <1634805.kh17mYrJe5@wuerfel>
 <CACxGe6tVk4na2yLi-6r1fTv5QqzgePbo6K+ZtEt-VOy25DQxVQ@mail.gmail.com>
 <2173132.bncoOm6QsM@wuerfel>
 <CACRpkdat0Z9vAc9YB0T9s+Cex6FbyHnT_Nj0OV3FLnQbexZqwg@mail.gmail.com>
Message-ID: <20130222142932.1A5B03E06AF@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Feb 2013 22:35:49 +0100, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Feb 21, 2013 at 11:44 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > An architecture should not unconditionally enable 'GENERIC_GPIO'
> > without providing an implementation. In case of arm64, selecting
> > ARCH_WANT_OPTIONAL_GPIOLIB is the right solution, because it
> > lets us enable GPIOLIB when configuring the kernel, and that
> > implicitly turns on GENERIC_GPIO.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Okay, I've put this into my gpio/next branch and I'll ask Linus to pull
shortly. Thanks everyone.

g.
