From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 13 May 2013 13:36:59 -0400
Subject: [PATCH V2 2/3] Documentation: virtio: Add emergency write
 (emerg_wr) config register in virtio console.
In-Reply-To: <CAAHg+Hi6BHqwOznnC9qxkc5pBWz7r5qpz9Nhh=EeNenhjhHohg@mail.gmail.com>
References: <1367842791-30285-1-git-send-email-pranavkumar@linaro.org>
 <1367842791-30285-3-git-send-email-pranavkumar@linaro.org>
 <8761yn382w.fsf@rustcorp.com.au>
 <CAAHg+Hi6BHqwOznnC9qxkc5pBWz7r5qpz9Nhh=EeNenhjhHohg@mail.gmail.com>
Message-ID: <519124BB.9030709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pranavkumar,

On 05/13/2013 02:56 AM, Pranavkumar Sawargaonkar wrote:
> Hi Rusty,
> 
> On 13 May 2013 08:22, Rusty Russell <rusty@rustcorp.com.au> wrote:
>> Pranavkumar Sawargaonkar <pranavkumar@linaro.org> writes:
>>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>>> ---
>>>  Documentation/virtual/virtio-spec.txt |    8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> OK, I applied this to the lyx master, with three changes:
>> 1) Changed "filed" to "field".
>> 2) Added ", or even acknowledging the feature" after "without
>>    initializing virtio queues".
>> 3) Added an initial point to the Device Initialization section:
>>
>>    1. If the VIRTIO_CONSOLE_F_EMERG_WRITE feature is offered, the
>>    emerg_wr field of the configuration can be written at any time. Thus
>>    it should work for very early boot debugging output as well as
>>    catastophic OS failures (eg. virtio ring corruption).
> 
> Thanks for applying this patch.
> Have you also applied first patch ([PATCH V2 1/3] virtio: console: Add
> emergency writeonly register to config space)
> with this?  (https://lkml.org/lkml/2013/5/6/169)

You seem to have omitted copying virtualization at lists.linux-foundation.org,
the mailing list documented in the MAINTAINERS file as appropriate for changes
relating to the virtio console driver.

[...]

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
