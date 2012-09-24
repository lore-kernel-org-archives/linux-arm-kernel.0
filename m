From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 24 Sep 2012 22:59:04 +0200
Subject: [PATCH 1/1] mfd: Provide the PRCMU with its own IRQ domain
In-Reply-To: <CACRpkdbmDtsb7cxWLeuBKyz0RYDX6uQjnm0uHd_ndY+NKdnHhw@mail.gmail.com>
References: <1348474306-25155-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdbmDtsb7cxWLeuBKyz0RYDX6uQjnm0uHd_ndY+NKdnHhw@mail.gmail.com>
Message-ID: <20120924205904.GF28670@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, Sep 24, 2012 at 10:14:02PM +0200, Linus Walleij wrote:
> On Mon, Sep 24, 2012 at 10:11 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > The PRCMU has its own USB, Thermal, GPIO, Modem, HSI and RTC drivers,
> > amongst other things. This patch allows those subordinate devices to
> > use it as an interrupt controller as and when they are DT enabled.
> >
> > CC: Samuel Ortiz <sameo@linux.intel.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> This is good stuff.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Sam, please pick this up, IRQdomains are a pathway to many
> good things.
Yes, I asked Lee to re-spin this one so that I could pick it up.
Applied and pushed now, thanks guys.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
