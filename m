From: tony@atomide.com (Tony Lindgren)
Date: Fri, 15 Feb 2013 08:37:55 -0800
Subject: [PATCH v8 09/12] pinctrl: generic: add auto pull config parameter
In-Reply-To: <CACRpkdYKAexLu30M2KzKcRcvRJS=xfVMB2vR+CgAXmwQ0+_ZzA@mail.gmail.com>
References: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
 <1360602659-4774-10-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdYKAexLu30M2KzKcRcvRJS=xfVMB2vR+CgAXmwQ0+_ZzA@mail.gmail.com>
Message-ID: <20130215163755.GB5724@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [130215 00:58]:
> On Mon, Feb 11, 2013 at 6:10 PM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
> 
> > There's only one bit to control pin bias as enabled or disabled for some
> > pins in OMAP SoC. So append PIN_CONFIG_BIAS_AUTO_PULL for this case.
> > User shouldn't switch pin state between AUTO_PULL and PULL_UP/PULL_DOWN,
> > since they're similiar concepts.
> >
> > Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> 
> Makes perfect sense.
> Patch applied with Tony's ACK!

Sorry the conclusion was that this probably won't be needed and can
probably be done with just PULL_UP/PULL_DOWN.

So can you please drop or revert this AUTO_PULL one?

Regards,

Tony
