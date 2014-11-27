From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 27 Nov 2014 12:53:18 -0500
Subject: [PATCHv2 05/16] gpio: mvebu: add suspend/resume support
In-Reply-To: <CACRpkdb5S7Fv4+Ck2btLPTYWaWr_E-iMcQGeATB4NMwx_T-4GA@mail.gmail.com>
References: <1415978496-9334-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1415978496-9334-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <CACRpkdb5S7Fv4+Ck2btLPTYWaWr_E-iMcQGeATB4NMwx_T-4GA@mail.gmail.com>
Message-ID: <20141127175318.GL22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 02:29:47PM +0100, Linus Walleij wrote:
> On Fri, Nov 14, 2014 at 4:21 PM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> 
> > This commit adds the implementation of ->suspend() and ->resume()
> > platform_driver hooks in order to save and restore the state of the
> > GPIO configuration. In order to achieve that, additional fields are
> > added to the mvebu_gpio_chip structure.
> >
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Alexandre Courbot <gnurou@gmail.com>
> > Cc: linux-gpio at vger.kernel.org
> > Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> > Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Do you want me to merge the patch or is it dependent on other patches?

I have a separate branch for this series, mvebu/soc-suspend which
contains everything.  I've been a bit wrapped around the axle this
cycle, and didn't want the series to suffer for lack of testing.  So
when I had a moment, I put the whole thing into mvebu/for-next.  It's
been there for a while.

If you don't mind, I can just send a pull request to arm-soc for the
branch as is.

I can break it up also, but I can't guarantee my availability for the
next week or two.  So there a risk of the arch changes not making it in.

thx,

Jason.
