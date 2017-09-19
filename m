From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Tue, 19 Sep 2017 09:24:29 +0000
Subject: linux-4.14-rc1/drivers/clk/clk-stm32h7.c: 2 * possible typo ?
In-Reply-To: <73cadb19-a75e-4938-265f-890cc5a4d3b4@st.com>
References: <12ce6ec0-d351-4ffe-a5a0-cdc09f6aee39@st.com>
 <73cadb19-a75e-4938-265f-890cc5a4d3b4@st.com>
Message-ID: <0abb5cce-f98f-b3c1-4d53-7ae4bd0e44dd@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I missed David ...


On 09/19/2017 11:22 AM, Gabriel FERNANDEZ wrote:
> Hi David,
>
> I confirm it's typo issue. I 'm ready to send a fix for that.
>
> Many Thank's
>
> Gabriel
>
>> Hello there,
>>
>> 1.
>>
>> linux-4.14-rc1/drivers/clk/clk-stm32h7.c:387]: (style) Same expression
>> on both sides of '&&'.
>>
>> Source code is
>>
>>    ??? if (gcfg->mux && gcfg->mux) {
>>
>> 2.
>>
>> [linux-4.14-rc1/drivers/clk/clk-stm32h7.c:413]: (style) Same expression
>> on both sides of '&&'.
>>
>> Duplicate.
>>
>> Regards
>>
>> David Binderman
