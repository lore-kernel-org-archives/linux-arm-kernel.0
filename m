From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 24 Sep 2012 23:42:09 +0200
Subject: [RFC PATCH 0/6] pinctrl: samsung: Convert the driver to use
 per-bank GPIO and interrupt specifiers
In-Reply-To: <CACRpkdaqaaNf=S9CMzYE3zpji0pCK1MLKeBm3uH7-18HHwPV3w@mail.gmail.com>
References: <1348237377-21299-1-git-send-email-t.figa@samsung.com>
 <CACRpkdaqaaNf=S9CMzYE3zpji0pCK1MLKeBm3uH7-18HHwPV3w@mail.gmail.com>
Message-ID: <5294133.e1Q4XgYR6l@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Monday 24 of September 2012 12:43:23 Linus Walleij wrote:
> On Fri, Sep 21, 2012 at 4:22 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> > This is a continuation of work focused on improving the pinctrl-samsung
> > driver.
> 
> All look good to me, I guess these will go through the Samsung tree?
> Acked-by: Linus Walleij <linus.walleij@linaro.org> for all.

Hmm, these patches are just at RFC stage at the moment and depend on the 
first part which does somewhat heavy reorganization of the driver. So this 
is more like a proof of concept.

After we settle all the things being discussed I will send a ready patch 
series including both of these parts.

Thanks for your ack anyway.

Best regards,
Tomasz Figa
