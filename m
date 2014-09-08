From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 8 Sep 2014 15:51:26 -0600
Subject: [PATCH 08/11 v5] coresight: adding documentation for coresight
In-Reply-To: <CACRpkdbD3Ds=iPxwD57ERd=xPAyVvdVbMEfjqdtAvO-0YqT_EA@mail.gmail.com>
References: <1409159852-7249-1-git-send-email-mathieu.poirier@linaro.org>
 <1409159852-7249-9-git-send-email-mathieu.poirier@linaro.org>
 <CACRpkdbD3Ds=iPxwD57ERd=xPAyVvdVbMEfjqdtAvO-0YqT_EA@mail.gmail.com>
Message-ID: <CANLsYkzrXcx9UCc6bxfKR59sjDwg=p1YhKWAS5YV0iYZNH67Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apologies on the late reply - I was doing a quick review of your
earlier comments before getting ready for another submission when I
remembered I hadn't address this one.  Pls see below.

On 3 September 2014 02:43, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Aug 27, 2014 at 7:17 PM,  <mathieu.poirier@linaro.org> wrote:
>
>> From: Mathieu Poirier <mathieu.poirier@linaro.org>
>>
>> Documentation for the coresight framework and drivers.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> (...)
>>  Documentation/trace/coresight.txt | 237 ++++++++++++++++++++++++++++++++++++++
>
> I guess you agreed on this location? If it's ARM-specific,
> Documentation/arm/coresight.txt
> is an alternative.

I didn't have prior agreement with anyone before - it was simply
dropped there to get the conversation started.  Very well, I'll move
it to @arm.

>
>> +The file cstrace.bin can be decompressed using "ptm2human", DS-5 or Trace32.
>
> Is ptm2human a candidate for the kernel tools/ directory?

A fair amount of work would have to be invested in "ptm2human" to make
it production ready.

>
> Maybe not now but later?
>
> +root at linaro-developer:/sys/kernel/debug/coresight# ls
>
> Maybe reduce noise here:
>
> root:/sys/kernel/debug/coresight# ls
>
> The reader probably does not need to know the name of your
> development system.

Ok.

>
> Yours,
> Linus Walleij
