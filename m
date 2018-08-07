From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Tue, 7 Aug 2018 12:01:05 +0000
Subject: [PATCH 1/3] ARM: dts: stm32: Fix DT dtc warnings for stm32h7
In-Reply-To: <f5933d5c-8da3-5112-351c-6b1ba669a9b6@st.com>
References: <1533639995-27047-1-git-send-email-patrice.chotard@st.com>
 <1533639995-27047-2-git-send-email-patrice.chotard@st.com>
 <8bd7a402-fc88-f4d9-451f-9533f2898ce0@st.com>
 <f5933d5c-8da3-5112-351c-6b1ba669a9b6@st.com>
Message-ID: <9570b293-6467-c8bb-4f08-71c07371730a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I will send a v2

Thanks for reviewing ;-)

Patrice

On 08/07/2018 01:56 PM, Alexandre Torgue wrote:
> Hi Patrice
> 
> On 08/07/2018 01:38 PM, Alexandre Torgue wrote:
>>> +??? #address-cells = <1>;
>>> +??? #size-cells = <1>;
>>> +
>>> ????? clocks {
>>> ????????? clk_hse: clk-hse {
>>> ????????????? #clock-cells = <0>;
>>> @@ -60,7 +62,7 @@
>>> ????????????? clock-frequency = <32768>;
>>> ????????? };
>>> -??????? clk_i2s: i2s_ckin {
>>> +??????? clk_i2s: i2s-ckin {
>>
>> clock driver deals with "i2s_ckin" for clock? source selection. I need 
>> to check deeper if this change could cause an issue.
> 
> Sorry I didn't check in the well driver. As far I can see it's ok for 
> this part of patch.
> 
> cheers
> Alex
> 
>>
>> thx
>> Alex
