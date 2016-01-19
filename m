From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 19 Jan 2016 07:53:46 +0000
Subject: [PATCH 1/3] clk: Allow clocks to be marked as CRITICAL
In-Reply-To: <CAMuHMdWoj=MT+-Tb+o6ocy2WKsZ42-ZUmN-Oe4ogNssgToFngw@mail.gmail.com>
References: <1453127331-20616-1-git-send-email-lee.jones@linaro.org>
 <1453127331-20616-2-git-send-email-lee.jones@linaro.org>
 <CAMuHMdWoj=MT+-Tb+o6ocy2WKsZ42-ZUmN-Oe4ogNssgToFngw@mail.gmail.com>
Message-ID: <20160119075346.GA29000@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Jan 2016, Geert Uytterhoeven wrote:
> On Mon, Jan 18, 2016 at 3:28 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -31,6 +31,7 @@
> >  #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
> >  #define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
> >  #define CLK_RECALC_NEW_RATES   BIT(9) /* recalc rates after notifications */
> > +#define CLK_IS_CRITICAL                BIT(10) /* do not gate, ever */
> 
> 10 is already taken, even upstream. Please rebase ;-)

Thanks for the heads-up.  Will pull Heiko's patch in and rebase.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
