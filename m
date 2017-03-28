From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 28 Mar 2017 15:49:58 +0200
Subject: [PATCH v5 1/5] usb: dwc2: Add support for STM32F429/439/469 USB
 OTG HS/FS in FS mode (internal PHY)
In-Reply-To: <8760ith6a6.fsf@linux.intel.com>
References: <20170201012547.76158-1-bruherrera@gmail.com>
 <20170201012547.76158-2-bruherrera@gmail.com>
 <2B3535C5ECE8B5419E3ECBE300772909021B411720@US01WEMBX2.internal.synopsys.com>
 <58187797-2c11-c75b-571c-27fe64578099@st.com>
 <8760ith6a6.fsf@linux.intel.com>
Message-ID: <d3711b3b-401d-87c7-20bd-a88364ef15a1@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/28/2017 03:36 PM, Felipe Balbi wrote:
>
> Hi,
>
> Alexandre Torgue <alexandre.torgue@st.com> writes:
>> Hi John,
>>
>> On 02/01/2017 04:37 AM, John Youn wrote:
>>> On 1/31/2017 5:26 PM, Bruno Herrera wrote:
>>>> This patch introduces a new parameter to activate USB OTG HS/FS core
>>>> embedded phy transceiver. The STM32F4x9 SoC uses the GGPIO register
>>>> to enable the transceiver.
>>>> Also add the dwc2_set_params function for stm32f4 otg fs.
>>>>
>>>> Signed-off-by: Bruno Herrera <bruherrera@gmail.com>
>>>
>>> Acked-by: John Youn <johnyoun@synopsys.com>
>>>
>> Do you plan to take those patches on your pull-request for 4.12?
>> I was wondering if I take machine parts (DT) in my pull request for 4.12
>> or if I wait an official version with driver part merged.
>
> patches already in my queue for v4.12

Thanks for info.

Regards
Alex

>
