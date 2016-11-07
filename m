From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Nov 2016 16:21:37 +0100
Subject: [PATCH 1/2] cpufreq: enable the DT cpufreq driver on the
 Integrators
In-Reply-To: <1477380085-6929-1-git-send-email-linus.walleij@linaro.org>
References: <1477380085-6929-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdbmaUaQibmTEmORw3mTGLQOfDUwg8zx=wRd3UvFcEtZvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 9:21 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This enables the generic DT and OPP-based cpufreq driver on the
> ARM Integrator/AP and Integrator/CP.
>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Rafael could you merge these two patches so that I can merge the
corresponding DTS files into the ARM SoC tree?

Yours,
Linus Walleij
