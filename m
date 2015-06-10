From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 10 Jun 2015 10:49:55 -0700
Subject: [PATCH v9 4/5] serial: stm32-usart: Add STM32 USART Driver
In-Reply-To: <CALszF6AaS-i2MBF64mJKtY2h5Sb710Z50Mf8wHotUBysukfZbw@mail.gmail.com>
References: <1432328616-16964-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1432328616-16964-5-git-send-email-mcoquelin.stm32@gmail.com>
 <20150531215246.GA24174@kroah.com>
 <CALszF6B7_xOMvO9pRJJPNeR4JnOgAQAohSARDivzt2d1DQWP_Q@mail.gmail.com>
 <20150610154240.GC22214@kroah.com>
 <CALszF6AaS-i2MBF64mJKtY2h5Sb710Z50Mf8wHotUBysukfZbw@mail.gmail.com>
Message-ID: <20150610174955.GA6527@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 10, 2015 at 06:18:37PM +0200, Maxime Coquelin wrote:
> 2015-06-10 17:42 GMT+02:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> > On Wed, Jun 10, 2015 at 01:33:22PM +0200, Maxime Coquelin wrote:
> >> 2015-05-31 23:52 GMT+02:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> >> > On Fri, May 22, 2015 at 11:03:35PM +0200, Maxime Coquelin wrote:
> >> >> This drivers adds support to the STM32 USART controller, which is a
> >> >> standard serial driver.
> >> >>
> >> >> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> >> >> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
> >> >> Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >> >> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >> >> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> >> >
> >> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>
> >> Thanks Greg.
> >>
> >> Will you apply it to your tty tree for v4.2? Or it should go in
> >> someone else tree?
> >
> > It's not in my queue, I'm guessing it goes in through some other tree as
> > there are build dependancies here preventing me from taking it.
> 
> There should not be any build dependencies.
> I just tested it on my x86 machine with COMPILE_TEST on both v4.1-rc1
> and tty-next branch.
> In both case it compiles without warnings.

Ok, then feel free to resend it as a stand-alone patch please and I will
queue it up.

thanks,

greg k-h
