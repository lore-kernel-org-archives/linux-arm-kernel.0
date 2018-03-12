From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Mon, 12 Mar 2018 09:06:11 +0000
Subject: [PATCH v2 01/12] dt-bindings: Document STM32MP1 Reset Clock
 Controller (RCC) bindings
In-Reply-To: <20180309235356.qd2wx6teeuxkwwjz@rob-hp-laptop>
References: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
 <1520528045-18330-2-git-send-email-gabriel.fernandez@st.com>
 <20180309235356.qd2wx6teeuxkwwjz@rob-hp-laptop>
Message-ID: <7d552f25-a7b8-c99a-8f28-eb9beb455724@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Rob !

Best Regards

Gabriel


On 03/10/2018 12:53 AM, Rob Herring wrote:
> On Thu, Mar 08, 2018 at 05:53:54PM +0100, gabriel.fernandez at st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> The RCC block is responsible of the management of the clock and reset
>> generation for the complete circuit.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>> ---
>>   .../devicetree/bindings/clock/st,stm32mp1-rcc.txt  | 60 ++++++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.txt
> Reviewed-by: Rob Herring <robh@kernel.org>
