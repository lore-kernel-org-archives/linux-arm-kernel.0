From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Jun 2013 15:16:34 +0200
Subject: [PATCH v2 04/11] mfd:stixxxx-syscfg: Add ST System Configuration
 support.
In-Reply-To: <1370856147-6552-1-git-send-email-srinivas.kandagatla@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856147-6552-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <CACRpkdaW2ALTWCB7Rd8m=aAGQwh3T_dJVncxJn_eXer4X3J6_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 11:22 AM, Srinivas KANDAGATLA
<srinivas.kandagatla@st.com> wrote:

> This mfd driver provides higher level inialization routines for various
> IPs like Ethernet, USB, PCIE, SATA and so on. Also it provides way to
> get to syscfg registers via standard regmap api which is usefull for
> drivers like pinctrl.
>
> This patch adds support to ST System Configuration registers, which can
> be configured by the drivers.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> CC: Stuart Menefy <stuart.menefy@st.com>
> CC: Stephen Gallimore <stephen.gallimore@st.com>
> CC: Linus Walleij <linus.walleij@linaro.org>
> CC: Mark Brown <broonie@kernel.org>

What is this driver doing that drivers/mfd/syscon.c is not already
doing?

I just get the feeling that you're reinventing the wheel here.

Yours,
Linus Walleij
