From: ludovic.barre@st.com (Ludovic BARRE)
Date: Wed, 13 Dec 2017 09:40:50 +0100
Subject: [PATCH 1/1] dt-bindings: arm: document supported STM32 SoC family
In-Reply-To: <20171212231744.u4wtadrpaq3wp4sq@rob-hp-laptop>
References: <1512741394-27341-1-git-send-email-ludovic.Barre@st.com>
 <20171212210348.proilmqmxf4yl5jn@rob-hp-laptop>
 <20171212231744.u4wtadrpaq3wp4sq@rob-hp-laptop>
Message-ID: <16700917-a53a-c319-d27d-f447c6ed3dce@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Rob

Today there was no bindings documentation for STM32 SoC
already upstreamed. This patch adds initial list of STM32
existing in kernel.
The next serie adds just new soc and one compatible on STM32 list.
So, I think you could apply this patch.

BR
Ludo

On 12/13/2017 12:17 AM, Rob Herring wrote:
> On Tue, Dec 12, 2017 at 03:03:48PM -0600, Rob Herring wrote:
>> On Fri, Dec 08, 2017 at 02:56:34PM +0100, Ludovic Barre wrote:
>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> This adds a list of supported STM32 SoC bindings.
>>>
>>> Signed-off-by: Gwenael Treuveur <gwenael.treuveur@st.com>
>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>> ---
>>>   Documentation/devicetree/bindings/arm/stm32.txt | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/arm/stm32.txt
>>
>> Applied, thanks.
> 
> Now dropped as this will conflict with your other series. Send this with
> the other series or indicate who should apply.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Rob
> 
