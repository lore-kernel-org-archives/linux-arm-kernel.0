From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Mar 2014 15:20:30 +0100
Subject: [PATCH v4 0/6] Add STiH407 SoC and reference board support
In-Reply-To: <1394614210-15698-1-git-send-email-maxime.coquelin@st.com>
References: <1394614210-15698-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <CACRpkdboBkzcJC35-BNvVYmS_t9Cd204AVz4rZasKtNJp0yE4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 9:50 AM, Maxime COQUELIN <maxime.coquelin@st.com> wrote:

> This series adds basic support to the STMicroelectronics STiH407 SoC and its
> B2120 reference board. The STiH407 is a dual-core ARM Cortex-A9 CPU aimed at
> STB market.
>
> Changes since v3:

I've applied the pinctrl changes to the pinctrl tree, please push all the
DTS[i] changes through ARM SoC.

There is no need to keep DTS and subsystem changes in sync as
the DTS'es are supposed to be maintained in separation in the
future anyway.

Yours,
Linus Walleij
