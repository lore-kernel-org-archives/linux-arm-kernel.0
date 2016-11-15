From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 Nov 2016 09:43:09 +0100
Subject: [PATCH v4 2/2] pinctrl: samsung: Add GPF support for Exynos5433
In-Reply-To: <1478680811-24835-3-git-send-email-cw00.choi@samsung.com>
References: <1478680811-24835-1-git-send-email-cw00.choi@samsung.com>
 <1478680811-24835-3-git-send-email-cw00.choi@samsung.com>
Message-ID: <CACRpkdbnUrcJk+78TiNi0eHQeFt0oLn_m_74NJCW9o+6LQS=3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2016 at 9:40 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:

> This patch add the support of GPF[1-5] pin of Exynos5433 SoC. The GPFx need
> to support the multiple memory map because the registers of GPFx are located
> in the different domain.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: linux-gpio at vger.kernel.org
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Patch applied.

Yours,
Linus Walleij
