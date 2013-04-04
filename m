From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 4 Apr 2013 17:29:56 +0200
Subject: [PATCH v2] ARM: at91: add Acme Systems Aria G25 board
In-Reply-To: <515C7E94.6030702@interlog.com>
References: <1364201369-12047-1-git-send-email-nicolas.ferre@atmel.com>
 <1364297952-32473-1-git-send-email-nicolas.ferre@atmel.com>
 <CAOesGMj+etPUMWffx2CiDtbWbB9A5_6QPbkTsmbEqCiBnkhm3A@mail.gmail.com>
 <515C7E94.6030702@interlog.com>
Message-ID: <515D9C74.5050207@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 09:10 PM, Douglas Gilbert :
> On 13-04-02 02:48 PM, Olof Johansson wrote:
>> Hi,
>>
>> I just saw this since it came in through a pull request
>>
>> On Tue, Mar 26, 2013 at 4:39 AM, Nicolas Ferre
>> <nicolas.ferre@atmel.com> wrote:
>>> From: Douglas Gilbert <dgilbert@interlog.com>
>>>
>>> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
>>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>> ---
>>>   arch/arm/boot/dts/ariag25.dts | 175
>>> ++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 175 insertions(+)
>>>   create mode 100644 arch/arm/boot/dts/ariag25.dts
>>>
>>> diff --git a/arch/arm/boot/dts/ariag25.dts
>>> b/arch/arm/boot/dts/ariag25.dts
>>> new file mode 100644
>>> index 0000000..b43266f
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/ariag25.dts
>>
>> Please prefix the boards with the platform. Most other SoCs already do
>> this, and I see now that some at91 boards haven't been prefixed in the
>> past, but it's a good idea to not add more of them.
>>
>> So, at91-ariag25.dts is a good name in this case.
> 
> That is fine with me. I have changed my working DT
> config file to at91-ariag25.dts and will push that
> out to Robert Nelson soon.
> 
> Also I'm working on a DT version of an existing Acme
> product called the FoxG20 which is based on the
> AT91SAM9G20 SoC. It already has non-DT support inside
> the mainline kernel. I am using at91-foxg20.dts for
> its DT config file.

Yep! Works for me.

Bye,
-- 
Nicolas Ferre
