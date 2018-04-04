From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Wed, 4 Apr 2018 10:13:19 +0200
Subject: [PATCH v2 2/6] i2c: i2c-stm32f7: Add slave support
In-Reply-To: <20180403152604.udgh4v2erpsupgo3@ninjato>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-3-git-send-email-pierre-yves.mordret@st.com>
 <20180325181600.vehqe3xcx55qxtd7@katana>
 <94737125-c0b7-08ca-c2f7-feb4e5d0498c@st.com>
 <20180403152604.udgh4v2erpsupgo3@ninjato>
Message-ID: <a6218454-d44c-7888-2688-d24bf5bc97f4@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/03/2018 05:26 PM, Wolfram Sang wrote:
> On Mon, Mar 26, 2018 at 10:41:51AM +0200, Pierre Yves MORDRET wrote:
>>
>>
>> On 03/25/2018 08:16 PM, Wolfram Sang wrote:
>>> On Wed, Mar 21, 2018 at 05:48:56PM +0100, Pierre-Yves MORDRET wrote:
>>>> This patch adds slave support for I2C controller embedded in STM32F7 SoC
>>>>
>>>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>>>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>>>
>>> Looks OK from a first look. What kind of tests did you do?
>>
>> As mentioned for 10-bit, I'm using 2 I2C instances from the SoC.
>> Here are the tests I dit:
>>  - Master/slave send in 7 and 10 bits
>>  - master/slave recv in 7 and 10 bits
>>  - E2PROM Read/Write
> 
> As far as I understand the code now, both instances can be master /
> slave simultanously on the same bus?
> 

Correct.
