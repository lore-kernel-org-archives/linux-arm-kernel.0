From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 29 Oct 2012 20:27:56 +0900
Subject: [PATCH 3/4] pinctrl: samsung: Add support for Exynos4x12
In-Reply-To: <2350814.8tYbDqrzVz@amdc1227>
References: <1351089457-8205-1-git-send-email-t.figa@samsung.com>
 <CACRpkdaoQP2jat_mr2wr30M39eogKAq77Gw2VoNPWbgHjgW+zw@mail.gmail.com>
 <CAH9JG2V2UjuvjK2_sjLQsEt21duCqyoQuAi0KsMfB+CjRrh8KQ@mail.gmail.com>
 <2350814.8tYbDqrzVz@amdc1227>
Message-ID: <508E683C.6040807@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/12 19:28, Tomasz Figa wrote:
> Hi Linus, Kyungmin,
>
> On Monday 29 of October 2012 09:30:26 Kyungmin Park wrote:
>> On 10/29/12, Linus Walleij<linus.walleij@linaro.org>  wrote:
>>> On Wed, Oct 24, 2012 at 4:37 PM, Tomasz Figa<t.figa@samsung.com>
> wrote:
>>>> This patch extends the driver with any necessary SoC-specific
>>>> definitions to support Exynos4x12 SoCs.
>>>>
>>>> Signed-off-by: Tomasz Figa<t.figa@samsung.com>
>>>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
>>>
>>> Acked-by: Linus Walleij<linus.walleij@linaro.org>
>>>
>>> I guess you need all of this to go into my Samsung branch?
>>> I need and ACK from the Samsung maintainer and preferably
>>> Thomas A as well.
>>
>> Hi,
>>
>> Now we're trying to send the standalone patches to avoid the conflict.
>> and hope to merge patches via proper subsystem. In this case, pinctl.
>
> Since this depends on the patch adding Exynos4x12 dts files
> ([PATCH] ARM: dts: exynos4: Add support for Exynos4x12 SoCs),
> which will be going through Kgene's tree and this patch series contains
> mostly SoC-specific code, maybe this should rather go through Kgene's
> tree? Or this is not a problem?
>
Yeah, I agree with Tomasz's opinion and let me pick this into Samsung 
tree with Linus's ack.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
