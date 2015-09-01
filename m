From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 1 Sep 2015 11:12:30 +0100
Subject: [PATCH v3 4/6] [media] c8sectpfe: Update binding to reset-gpios
In-Reply-To: <CAL_JsqLYes5L2Bg0R45ui24yYWgHzFSLgBPajieSLgLz09=1aw@mail.gmail.com>
References: <1440784362-31217-1-git-send-email-peter.griffin@linaro.org>
 <1440784362-31217-5-git-send-email-peter.griffin@linaro.org>
 <CAL_JsqLYes5L2Bg0R45ui24yYWgHzFSLgBPajieSLgLz09=1aw@mail.gmail.com>
Message-ID: <20150901101230.GB2316@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

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
> the commit message. I only point this out. I'll leave it to platform
> maintainers whether or not this breakage is acceptable.

Ok I will highlight that in the commit message of the next version.

regards,

Peter.
