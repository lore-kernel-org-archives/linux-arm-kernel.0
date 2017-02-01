From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 1 Feb 2017 13:51:00 +0100
Subject: [PATCH 2/3] pinctrl: dt-bindings: samsung: Add Exynos7 specific
 pinctrl macro definitions
In-Reply-To: <20170127144123.slmwxorx7cjxwtcr@kozik-lap>
References: <1484718141-28785-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170118054002epcas5p3b08e2f419976e17a3c584d64776810fd@epcas5p3.samsung.com>
 <1484718141-28785-3-git-send-email-pankaj.dubey@samsung.com>
 <20170118141935.eu7wmki7jnjdarkw@kozik-lap>
 <7a0d543f-37e8-98e9-15b4-7d3f808f8516@samsung.com>
 <20170127144123.slmwxorx7cjxwtcr@kozik-lap>
Message-ID: <CACRpkdYLpQHT1ykYE1tNJpNRyUt7ezhyxznbe=dPu70mPn0OLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 3:41 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Fri, Jan 27, 2017 at 01:25:42PM +0100, Sylwester Nawrocki wrote:
>> On 01/18/2017 03:19 PM, Krzysztof Kozlowski wrote:
>> > On Wed, Jan 18, 2017 at 11:12:20AM +0530, Pankaj Dubey wrote:
>> >> Exynos7 SoC pinctrl configurations are similar to existing Exynos4/5 except
>> >> for FSYS1 pinctrl drive strengths. So adding Exynos7 specific FSYS1 blocks
>> >> pinctrl driver strength related macros which will be used in Exynos7
>> >> DTSi files.
>> >>
>> >> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> >> ---
>> >>  include/dt-bindings/pinctrl/samsung.h | 8 ++++++++
>> >>  1 file changed, 8 insertions(+)
>> >>
>> >
>> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>> >
>> > I will need this header, so Sylwester if it is okay with you, could you
>> > provide a tag with it (or ack it)?
>>
>> Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>
>> I don't have pinctrl/samsung git tree, Linus applies patches directly.
>
> Oh, my mistake.
>
> Linus,
> This is similar case as "pinctrl: dt-bindings: samsung: add drive
> strength macros for Exynos5433" [1].

OK
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I expect that you take it through ARM SoC and/or send me a pull
request for it on an immutable branch, whatever is best.

Yours,
Linus Walleij
