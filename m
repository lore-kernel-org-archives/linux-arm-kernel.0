From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 6 Sep 2013 18:48:15 +0200
Subject: [PATCH v5 1/5] ARM: add basic Trusted Foundations support
In-Reply-To: <1378351680-14696-2-git-send-email-acourbot@nvidia.com>
References: <1378351680-14696-1-git-send-email-acourbot@nvidia.com>
 <1378351680-14696-2-git-send-email-acourbot@nvidia.com>
Message-ID: <CACRpkdaphSqM1oOphC-t1UPmkxaEemC3R3aDfEXb79GWNNyNMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 5, 2013 at 5:27 AM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> Trusted Foundations is a TrustZone-based secure monitor for ARM that
> can be invoked  using a consistent SMC-based API on all supported
> platforms. This patch adds initial basic support for Trusted
> Foundations using the ARM firmware API. Current features are limited
> to the ability to boot secondary processors.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>

I take it that this means that it is a set of standard routines
living in the secure world that can be called by way of this
API, correct? The commit message is written a bit like
everybody knows what this is about but I don't :-)

Some more background here would be nice, like where did this
thing come from, and are there other platforms in existance that
use trusted foundations or is it a Tegra-only thing? Does a
specification of this thing listing available services exist for
example?

How does it relate to the (arch-neutral) trusted execution
environment and such things that other vendors are pushing for?
Can the trusted foundations be used "underneath" such
frameworks for trusted applications, or is it a parallell thing
altogether?

Simple things like that...

I tried googling it, is this a relevant URL?
http://www.arm.com/community/partners/display_product/rw/ProductId/5393/

Thanks,
Linus Walleij
