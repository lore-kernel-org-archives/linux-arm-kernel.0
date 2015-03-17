From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Tue, 17 Mar 2015 08:49:17 +0100
Subject: [PATCH v2 4/5] PCI: designware: Add disable IO support
In-Reply-To: <550718B4.5090406@linaro.org>
References: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org>
 <1426515635-9466-5-git-send-email-gabriel.fernandez@linaro.org>
 <550718B4.5090406@linaro.org>
Message-ID: <CAG374jCD05qXiMfCZOPFvaxYLgU75CR3Kiryxxxz1CzmgVOsjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

Yes, you are right.

Nevertheless i'll try the Kumar and Arnd 's request to not use DT to do that.

BR

Gabriel

On 16 March 2015 at 18:53, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 16/03/15 14:20, Gabriel FERNANDEZ wrote:
>>
>>   - bus-range: PCI bus numbers covered (it is recommended for new
>> devicetrees to
>>     specify this property, to keep backwards compatibility a range of
>> 0x00-0xff
>>     is assumed if not present)
>> +- disable_io_support: set this property for PCIe host controller without
>> IO
>> +  port access
>
> Shouldn't dt properties use hyphens rather than under scores ?
