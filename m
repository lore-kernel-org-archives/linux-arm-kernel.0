From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Nov 2016 10:36:51 +0100
Subject: [PATCH v3 2/5] pinctrl: samsung: Add GPF support for Exynos5433
In-Reply-To: <20161103192002.GB12945@kozik-lap>
References: <1478155149-28527-1-git-send-email-cw00.choi@samsung.com>
 <1478155149-28527-3-git-send-email-cw00.choi@samsung.com>
 <20161103192002.GB12945@kozik-lap>
Message-ID: <CACRpkdabGcpDzvQq1rFP7uO8+mLuPDUHQgzh_ooUyy+0nTAvBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 3, 2016 at 8:20 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Nov 03, 2016 at 03:39:06PM +0900, Chanwoo Choi wrote:
>> This patch add the support of GPF[1-5] pin of Exynos5433 SoC. The GPFx need
>> to support the multiple memory map because the registers of GPFx are located
>> in the different domain.
>>
>> Cc: Tomasz Figa <tomasz.figa@gmail.com>
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-gpio at vger.kernel.org
>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/pinctrl/samsung/pinctrl-exynos.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>
> I think that, instead of in previous patch, the
> "samsung,exynos5433-pinctrl" compatible should be documented here along
> with information that it requires two addresses for mappings.

True but too small detail to respin the patches about,
and I'm not perfectionist, so patch applied anyways.

Yours,
Linus Walleij
