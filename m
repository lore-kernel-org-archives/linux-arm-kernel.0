From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 14 Aug 2013 23:30:48 +0800
Subject: [PATCH 2/5] ARM: pxa: ssp: add shortcut for &pdev->dev
In-Reply-To: <5209F619.4000503@gmail.com>
References: <1376296638-19804-1-git-send-email-zonque@gmail.com>
 <1376296638-19804-3-git-send-email-zonque@gmail.com>
 <20130812103834.GO6427@sirena.org.uk> <5208BBE5.5050306@gmail.com>
 <20130812104652.GP6427@sirena.org.uk> <5208BDEB.6070900@gmail.com>
 <5209F619.4000503@gmail.com>
Message-ID: <CAD6h2NTXDrOFXeYApgt5bSC=yHbYrozeTpf7B6ea94Hu_HWwNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 August 2013 17:02, Daniel Mack <zonque@gmail.com> wrote:
> On 12.08.2013 12:50, Daniel Mack wrote:
>> On 12.08.2013 12:46, Mark Brown wrote:
>>> On Mon, Aug 12, 2013 at 12:41:41PM +0200, Daniel Mack wrote:
>>>> I actually thought Haojian would pick them, but I see there's a build
>>>> dependency. So it might make sense if you take them instead.
>>>
>>> They didn't obviously touch arch/arm
>>
>> Well yes, *this* series does:
>>
>>  .../devicetree/bindings/serial/mrvl,pxa-ssp.txt    |  65 ++++++++
>>  arch/arm/plat-pxa/ssp.c                            | 174
>> ++++++++++++++-------
>>  include/linux/pxa2xx_ssp.h                         |  11 ++
>>
>> I posted two series, one is for arch/arm and one is for sound/soc/pxa.
>> But as they have a dependency via pxa_ssp_request_of(), I'd actually
>> prefer if you took all of them.
>
> Haojian, could you give your Ack on this procedure?
>
>
> Thanks,
> Daniel
>
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
