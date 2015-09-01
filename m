From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 1 Sep 2015 08:58:11 +0100
Subject: [PATCH v3 4/6] [media] c8sectpfe: Update binding to reset-gpios
In-Reply-To: <CAL_JsqLYes5L2Bg0R45ui24yYWgHzFSLgBPajieSLgLz09=1aw@mail.gmail.com>
References: <1440784362-31217-1-git-send-email-peter.griffin@linaro.org>
 <1440784362-31217-5-git-send-email-peter.griffin@linaro.org>
 <CAL_JsqLYes5L2Bg0R45ui24yYWgHzFSLgBPajieSLgLz09=1aw@mail.gmail.com>
Message-ID: <20150901075811.GK4796@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 31 Aug 2015, Rob Herring wrote:

> On Fri, Aug 28, 2015 at 12:52 PM, Peter Griffin
> <peter.griffin@linaro.org> wrote:
> > gpio.txt documents that GPIO properties should be named
> > "[<name>-]gpios", with <name> being the purpose of this
> > GPIO for the device.
> >
> > This change has been done as one atomic commit.
> 
> dtb and kernel updates are not necessarily atomic, so you are breaking
> compatibility with older dtbs. You should certainly highlight that in
> the commit message.

Good idea.

> I only point this out. I'll leave it to platform
> maintainers whether or not this breakage is acceptable.

This driver is new.  The 'original' bindings are in next.  So this
binding is not even close to being ABI.

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
