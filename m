From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 23 Apr 2013 23:29:32 +0900
Subject: [PATCH v5 5/6] ARM: dts: Add basic dts include files for Samsung
 S3C64xx SoCs
In-Reply-To: <CAL_JsqL_i-5SDCsGZCrsxMehLVMGoLO1s_V3R-H6Oa5ff16dEQ@mail.gmail.com>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>	<1366060483-20342-6-git-send-email-tomasz.figa@gmail.com>	<516D4D76.2010409@gmail.com>	<1829212.6niSeTsyIU@amdc1227>
 <CAL_JsqL_i-5SDCsGZCrsxMehLVMGoLO1s_V3R-H6Oa5ff16dEQ@mail.gmail.com>
Message-ID: <51769ACC.4070706@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/13 02:46, Rob Herring wrote:

>>>> +   vic0: interrupt-controller at 71200000 {
>>>
>>> These nodes should be off a "simple-bus" node.
>>
>> Hmm, is there any reason behind it?
>>
>> I thought simple bus was just a convenient helper to represent hierarchical
>> bus structures if one has a need to do so.
>
> No. The DT should reflect the bus structure of the chip. How
> accurately it is done is up to you and the information available, but
> you have to have a bus of some sort.
>
> There's obvious examples that don't follow this, but I'd like to not have more.
>
Tomasz, can you address comments?

Thanks.

- Kukjin
