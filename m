From: yannick.fertre@st.com (Yannick FERTRE)
Date: Mon, 20 Feb 2017 11:01:25 +0000
Subject: [PATCH v2 4/9] dt-bindings: Add Ampire AM-480272H3TMQW-T01H panel
In-Reply-To: <20170216023408.apqukipi5zzkrk7j@rob-hp-laptop>
References: <1486738489-22154-1-git-send-email-yannick.fertre@st.com>
 <1486738489-22154-5-git-send-email-yannick.fertre@st.com>
 <20170216023408.apqukipi5zzkrk7j@rob-hp-laptop>
Message-ID: <2b409ff7-54fe-4110-6495-1cc54585e5e2@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/16/2017 03:34 AM, Rob Herring wrote:
> On Fri, Feb 10, 2017 at 03:54:44PM +0100, Yannick Fertre wrote:
>> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
>> ---
>>  .../bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt         | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
>> new file mode 100644
>> index 0000000..f59e3c4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
>> @@ -0,0 +1,7 @@
>> +Ampire AM-480272H3TMQW-T01H 4.3" WQVGA TFT LCD panel
>> +
>> +Required properties:
>> +- compatible: should be "ampire,am-480272h3tmqw-t01h"
>
> No GPIO controls or power supply for this panel?
>
> Rob
>

Hi Rob,
thank for your reply.
There is no gpio or power supply control for this panel with the eval 
board stm429x9i.
This binding is similar to all panel bindings which are link to panel 
simple. Details on gpio & power supply are describe with simple-panel 
binding.

Best regards

Example nvd,9128.txt:

New Vision Display 7.0" 800 RGB x 480 TFT LCD panel

Required properties:
- compatible: should be "nvd,9128"

This binding is compatible with the simple-panel binding, which is specified
in simple-panel.txt in this directory.
