From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Mar 2012 20:24:57 -0700
Subject: [PATCH 3/4] ARM: create a common IOMEM definition
In-Reply-To: <1331500100-31351-4-git-send-email-robherring2@gmail.com>
References: <1331500100-31351-1-git-send-email-robherring2@gmail.com>
 <1331500100-31351-4-git-send-email-robherring2@gmail.com>
Message-ID: <CAOesGMjwnAHNBHC7SR0qkFO0yiZ3kAEPhQwfTp00pHh6W4QsMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 11, 2012 at 2:08 PM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Several platforms create IOMEM defines for casting to 'void __iomem *',
> and other platforms are incorrectly using __io() macro for the same
> purpose. This creates a common definition and removes all the platform
> specific versions. Rather than try to make linux/io.h and asm/io.h
> assembly safe, the assembly version of IOMEM is moved into
> asm/assembler.h.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> Cc: Colin Cross <ccross@android.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Linus Walleij <linus.walleij@stericsson.com>

Acked-by: Olof Johansson <olof@lixom.net>  Tegra portions
