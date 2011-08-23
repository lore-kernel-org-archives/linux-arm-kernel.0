From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Aug 2011 10:17:31 +0200
Subject: [PATCH V3 00/20] dmaengine/amba-pl08x updates
In-Reply-To: <cover.1312538034.git.viresh.kumar@st.com>
References: <cover.1312538034.git.viresh.kumar@st.com>
Message-ID: <CACRpkdY6KW+tv7H==b15xJyeLp9HCqp9ROBhON0A8JnJDUn8Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 5, 2011 at 12:02 PM, Viresh Kumar <viresh.kumar@st.com> wrote:

> This patchset contains patches for ARM's pl08x DMA controller driver.
> Main changes introduced by this patchset are:
> - Formatting fixes
> - Logical Fixes
> - Support for Peripheral as flow controller
> - Support for sg_len to be greater than 1 for slave transfers
> - Schedule tasklet for error interrupts
> - remove pl08x_pre_boundary() routine
> - support for runtime PM
> - etc

I've now tested this patchset:

patch 3/20 fails to apply cleanly, need rebase on top of Russell's
fix for dma-mapping.h inclusion. It's a trivial fix.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Vinod could you apply all patches except for 16/18 which has some
discussion going on, so we get some rotation in -next? The rest of
Viresh:s patches are really nice stuff to have.

I will test on the PB11MPcore in the next few days.

Yours,
Linus Walleij
