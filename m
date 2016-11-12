From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 12 Nov 2016 21:13:15 +0200
Subject: [PATCH v2 1/2] arm64: dts: Add level for cpu dt node for exynos7
In-Reply-To: <CAGOxZ50Ttd1hP0x+Z527wc7mLLpz+Dom0TXFk08+mL0vnaxWwA@mail.gmail.com>
References: <1478945832-1826-1-git-send-email-alim.akhtar@samsung.com>
 <8a63bfe0-b23c-3583-6e5e-c17fe412e34d@osg.samsung.com>
 <CAGOxZ50Ttd1hP0x+Z527wc7mLLpz+Dom0TXFk08+mL0vnaxWwA@mail.gmail.com>
Message-ID: <CAJKOXPc5aJi9nVv4rd3pB_dkkoJWUjmkEyXF2Kxtp+6Y7VZdWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 12, 2016 at 6:00 PM, Alim Akhtar <alim.akhtar@gmail.com> wrote:
> Hi Javier,
>
> On Sat, Nov 12, 2016 at 7:54 PM, Javier Martinez Canillas
> <javier@osg.samsung.com> wrote:
>> Hello Alim,
>>
>> On 11/12/2016 07:17 AM, Alim Akhtar wrote:
>>> This patch adds level for cpu dt node, so that these levels can be used
>>
>> Do you mean s/level/label here? I'm asking because you are using level
>> consistently in the subject line and commit message but I'm not sure
>> what it means in this context.
>>
>
> Ah!! my bad. Its __label__. If required, will respin.
> Thanks for review.

I think there is no need of respin because this should be squashed
with previous patch. This is quite small and there are no functional
changes here (labels are transparent, except of course conflict
cases). Without the 2/2,  this patch does not have much sense yet.

Best regards,
Krzysztof
