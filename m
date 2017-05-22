From: robh@kernel.org (Rob Herring)
Date: Mon, 22 May 2017 07:58:48 -0500
Subject: [PATCH v1 2/3] dt-bindings: display: Add STM32 DSI host driver
In-Reply-To: <f8db9525-6c56-85f9-d3de-af7bb8312b46@st.com>
References: <1494600989-13507-1-git-send-email-philippe.cornu@st.com>
 <1494600989-13507-3-git-send-email-philippe.cornu@st.com>
 <20170518214200.e2mmsqpvm3rqnh72@rob-hp-laptop>
 <f8db9525-6c56-85f9-d3de-af7bb8312b46@st.com>
Message-ID: <CAL_JsqKUeQXJ-KqKkgwBHsapwW9XdwShSnBQ81RMKgW0XQbODA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 11:25 AM, Philippe CORNU <philippe.cornu@st.com> wrote:
>
>
> On 05/18/2017 11:42 PM, Rob Herring wrote:
>> On Fri, May 12, 2017 at 04:56:28PM +0200, Philippe CORNU wrote:
>>> This patch adds documentation of device tree bindings for the STM32
>>> DSI host driver based on the Synopsys DW MIPI DSI driver from Rockchip.
>>>
>>> Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
>>> ---
>>>   .../devicetree/bindings/display/st,stm32-ltdc.txt  | 92 +++++++++++++++++++++-
>>>   1 file changed, 90 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
>>> index 8e14769..a61381b 100644
>>> --- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
>>> +++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
>>> @@ -1,7 +1,6 @@
>>>   * STMicroelectronics STM32 lcd-tft display controller
>>>
>>>   - ltdc: lcd-tft display controller host
>>> -  must be a sub-node of st-display-subsystem
>>
>> Why is this removed? The "must" refers to the location, not whether
>> present or not if that's what you were trying to change.
>>
> Dear Rob,
> Many thanks for your comments.
>
> There is no need anymore to have a st-display-subsystem parent node in
> the device tree for the ltdc, that is why I removed this "must" information.

Okay, that's good because I'm not a fan of them. That seems like an
unrelated change though.

Rob
