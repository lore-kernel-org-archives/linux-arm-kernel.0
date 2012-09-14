From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 14 Sep 2012 09:14:51 +0100
Subject: [PATCH 18/19] gpio: Provide the tc3589x GPIO expander driver
 with an IRQ domain
In-Reply-To: <CACRpkdYbWEq5mhTcewmxEpcivXkVyQS_56QRU67G40zcRXnUCA@mail.gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-19-git-send-email-lee.jones@linaro.org>
 <CACRpkdYbWEq5mhTcewmxEpcivXkVyQS_56QRU67G40zcRXnUCA@mail.gmail.com>
Message-ID: <20120914081449.GC3374@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 06:10:59AM -0700, Linus Walleij wrote:
> On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > In preparation for Device Tree enablement all IRQ controllers
> > should control their own IRQ domain. This patch provides just
> > that for the tc3589x GPIO expander.
> >
> > CC: Grant Likely <grant.likely@secretlab.ca>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Looks very good again,
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I presume you will want to push the whole shebang through
> ARM SoC, but if that doesn't work out I am very tempted to
> apply this patch to the GPIO tree immediately so it lands
> in v3.7.

I'd like to push my patch-set for v3.7 too.

I just need to collect all my Acks before I can send a pull-request.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
