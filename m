From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Oct 2012 10:29:02 +0100
Subject: [PATCH 3/4] pinctrl: samsung: Add support for Exynos4x12
In-Reply-To: <508E683C.6040807@samsung.com>
References: <1351089457-8205-1-git-send-email-t.figa@samsung.com>
 <CACRpkdaoQP2jat_mr2wr30M39eogKAq77Gw2VoNPWbgHjgW+zw@mail.gmail.com>
 <CAH9JG2V2UjuvjK2_sjLQsEt21duCqyoQuAi0KsMfB+CjRrh8KQ@mail.gmail.com>
 <2350814.8tYbDqrzVz@amdc1227> <508E683C.6040807@samsung.com>
Message-ID: <CACRpkdb2i7Pv27oNg1wu6B8GzYb6j4XRU=LgnmMzSewscfxvPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 12:27 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:

> On 10/29/12 19:28, Tomasz Figa wrote:
>> On Monday 29 of October 2012 09:30:26 Kyungmin Park wrote:

>> Since this depends on the patch adding Exynos4x12 dts files
>> ([PATCH] ARM: dts: exynos4: Add support for Exynos4x12 SoCs),
>> which will be going through Kgene's tree and this patch series contains
>> mostly SoC-specific code, maybe this should rather go through Kgene's
>> tree? Or this is not a problem?
>>
> Yeah, I agree with Tomasz's opinion and let me pick this into Samsung tree
> with Linus's ack.

Seems to have worked out well, just one minor conflict in -next
so let's go for this...

Yours,
Linus Walleij
