From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Nov 2012 17:00:35 +0100
Subject: [PATCH 4/8] watchdog: sp805_wdt depends on ARM
In-Reply-To: <1353683310-23654-5-git-send-email-ciminaghi@gnudd.com>
References: <1353683310-23654-1-git-send-email-ciminaghi@gnudd.com>
 <1353683310-23654-5-git-send-email-ciminaghi@gnudd.com>
Message-ID: <CACRpkdb1e=4yV6pP1aw_p8vW0MQUDiV5ZQq1TzobyOKZN7gcXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 4:08 PM, Davide Ciminaghi <ciminaghi@gnudd.com> wrote:

> From: Alessandro Rubini <rubini@gnudd.com>
>
> The SP805 driver is only used by the Spear machines, and uses
> writel_relaxed, which is not available on all architectures.
>
> The dependency from CONFIG_ARM avoids compilation problems under
> randomconfig when CONFIG_ARM_AMBA is enabled for x86 builds.
>
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
> Signed-off-by: Davide Ciminaghi <ciminaghi@gnudd.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
