From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 23 Nov 2015 19:34:03 +0100
Subject: [PATCH] soc: Mediatek: Enable SCPSYS power domain driver by
 default
In-Reply-To: <CAMAWPa8ZcD30-06K3w1EewPMPA6LmU7bpOWbxi=VfsByyQT3Sw@mail.gmail.com>
References: <1447411835-19035-1-git-send-email-eddie.huang@mediatek.com>
 <7h4mgpdh6f.fsf@deeprootsystems.com>
 <CAMAWPa8ZcD30-06K3w1EewPMPA6LmU7bpOWbxi=VfsByyQT3Sw@mail.gmail.com>
Message-ID: <56535C1B.1090804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/11/15 21:05, Kevin Hilman wrote:
> On Fri, Nov 13, 2015 at 7:59 AM, Kevin Hilman <khilman@kernel.org> wrote:
>> Eddie Huang <eddie.huang@mediatek.com> writes:
>>
>>> If enable Mediatek 8173 SoC, it should also enable power domain
>>> driver. Otherwise access clk subsystem register will fail.
>>>
>>> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
>>
>> Tested-by: Kevin Hilman <khilman@linaro.org>
>>
>> This gets the mt8173-evb booting again with arm-soc/for-next and
>> mainline for me.
>>
>> I'll let Matthias queue this up and send it with any other fixes for
>> v4.4-rc1.
>
> Matthias, this is still broken in arm-soc.  Curious if your planning
> on sending a fix?  If you prefer, with your ack, we can apply directly
> to arm-soc/fixes.
>

Sorry for the delay. Please apply it directly.

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

Thanks a lot,
Matthias
