From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Nov 2016 10:36:04 +0100
Subject: [PATCH v3 2/5] pinctrl: samsung: Add GPF support for Exynos5433
In-Reply-To: <1478155149-28527-3-git-send-email-cw00.choi@samsung.com>
References: <1478155149-28527-1-git-send-email-cw00.choi@samsung.com>
 <1478155149-28527-3-git-send-email-cw00.choi@samsung.com>
Message-ID: <CACRpkdaBWBy__DhpUW0vKy90YWR8rHFjVkPDAC8rL05ZMnn6OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 3, 2016 at 7:39 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:

> This patch add the support of GPF[1-5] pin of Exynos5433 SoC. The GPFx need
> to support the multiple memory map because the registers of GPFx are located
> in the different domain.
>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-gpio at vger.kernel.org
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Patch applied.

Yours,
Linus Walleij
