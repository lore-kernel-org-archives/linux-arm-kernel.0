From: stillcompiling@gmail.com (Joshua Clayton)
Date: Fri, 7 Oct 2016 13:41:07 -0700
Subject: [PATCH 2/3] doc: dt: add cyclone-spi binding document
In-Reply-To: <CAAtXAHeZLBT-y8xTKgG4PnZA6DH1z5=FoaM4ipC3pTEVU9KR+Q@mail.gmail.com>
References: <cover.1475783742.git.stillcompiling@gmail.com>
 <4b4432c04b4ea92a2af814e3d7866c33f2eb12ea.1475783742.git.stillcompiling@gmail.com>
 <8d89e70475e8e1c3ce5117a0367c8444c11c61e3.1475783742.git.stillcompiling@gmail.com>
 <CAAtXAHeZLBT-y8xTKgG4PnZA6DH1z5=FoaM4ipC3pTEVU9KR+Q@mail.gmail.com>
Message-ID: <ffff9995-d3d2-de8e-54b1-468252a725c0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moritz,

thank you very much for the review.
 
On 10/06/2016 07:53 PM, Moritz Fischer wrote:
> Hi Joshua,
>
> On Thu, Oct 6, 2016 at 1:34 PM, Joshua Clayton <stillcompiling@gmail.com> wrote:
>> Describe a cyclonespi devicetree entry, required features
>>
>> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
>> ---
>>  .../bindings/fpga/cyclone-spi-fpga-mgr.txt         | 23 ++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/fpga/cyclone-spi-fpga-mgr.txt
>>
>> diff --git a/Documentation/devicetree/bindings/fpga/cyclone-spi-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/cyclone-spi-fpga-mgr.txt
>> new file mode 100644
>> index 0000000..8de34db
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fpga/cyclone-spi-fpga-mgr.txt
>> @@ -0,0 +1,23 @@
>> +Altera SOCFPGA FPGA Manager
> Copy & Paste? :)
Oops :(
As you might image, documentation was the last item done with the least attention.
Will fix.
>
>> +Altera cyclone FPGAs support a method of loading the bitstream over what is
> cyclone->Cyclone
OK.
>> +referred to as "passive serial".
>> +The passive serial link is not technically spi, and might require extra
>> +circuits in order to play nicely with other spi slaves on the same bus.
>> +
>> +See https://www.altera.com/literature/hb/cyc/cyc_c51013.pdf
>> +
>> +Required properties:
>> +- compatible  : should contain "altr,cyclonespi-fpga-mgr"
> Alan, do you guys have any input on the compat string?
I am open to change if it makes sense. I tried to keep the format similar.
> I think generally the bindings should go before the actual usage in
> your patch series. Meaning you wanna document the binding
> before you use it. I think this patch should be [1/3].
Ah, In my mind I had it backwards.
> Cheers,
>
> Moritz
I'll give Alan a chance to review and then spin a V2

Joshua Clayton
