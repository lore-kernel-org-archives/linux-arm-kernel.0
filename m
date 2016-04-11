From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Tue, 12 Apr 2016 05:15:01 +0900
Subject: [PATCH v9 00/20] PM / devferq: Add generic exynos bus frequency
 driver and new passive governor
In-Reply-To: <20160411195557.GA6426@kozik-lap>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
 <570B218E.5000908@samsung.com> <20160411195557.GA6426@kozik-lap>
Message-ID: <CAGTfZH3AVbo6w9KDVNNCs+JMi=+-CA0oL6pQ+3jcOFihtKaK3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On Tue, Apr 12, 2016 at 4:55 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On Mon, Apr 11, 2016 at 01:01:18PM +0900, Chanwoo Choi wrote:
>> Dear Myungjoo and Krzysztof,
>>
>> This patch-set already get the acked-by or signed-off-by tag
>> from Exynos SoC and DEVFREQ maintainer except for patch10.
>>
>> If there is no comment, could you pick this patch-set?
>
> I cannot find any description of dependencies between the patches so I
> assume the obvious one: DTS patches do not depend on anything. This
> means that:
> 1. driver/devfreq related changes (including dt-bindings documentation)
>    go to Myungjoo,
> 2. I can pick DTS changes.

Yes.

>
> But first I would like to see the bindings documentation beeing applied
> by someone as a proof that there won't be more development in DTS in
> these series. There is no sense of picking DTS if after comments from
> Rob, you will rework them, right?

I already discussed the Rob's question on December, last year on
patchset[1]. But, after that, I didn't receive the any reply from him.
[1] https://lkml.org/lkml/2015/12/10/943

So, I thought that there is no comment.  But, today, he give some
question after 4 months.

But I'll again reply to Rob's question.

>
> Anyway I see Rob's questions. For these bindings I think you should get
> DT-guys ack first.

OK.

Best Regards,
Chanwoo Choi
