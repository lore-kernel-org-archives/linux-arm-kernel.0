From: dianders@chromium.org (Doug Anderson)
Date: Fri, 20 Dec 2013 16:57:28 -0800
Subject: [PATCH 3/3] ARM: dts: Rename Exynos5250 ChromeOS common file to
 have exynos prefix
In-Reply-To: <52B4D4AC.10109@samsung.com>
References: <1385381710-5212-1-git-send-email-broonie@kernel.org>
 <1385381710-5212-3-git-send-email-broonie@kernel.org>
 <52B4CE30.6030205@samsung.com> <52B4D4AC.10109@samsung.com>
Message-ID: <CAD=FV=UBsmW9V=487F0MvXfTDDmWMRPwK=ZRbgwuQkE-FuJ_xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin,

On Fri, Dec 20, 2013 at 3:37 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> On 12/21/13 08:09, Kukjin Kim wrote:
>>
>> On 11/25/13 21:15, Mark Brown wrote:
>>>
>>> From: Mark Brown<broonie@linaro.org>
>>>
>>> Make it easier to notice the common file for ChromeOS devices based on
>>> the Exynos5250 by giving it the exynos5250 prefix that the boards have.
>>>
>>> Signed-off-by: Mark Brown<broonie@linaro.org>
>>> Acked-by: Tomasz Figa<t.figa@samsung.com>

The rename makes a lot of sense to me.

Reviewed-by: Doug Anderson <dianders@chromium.org>
