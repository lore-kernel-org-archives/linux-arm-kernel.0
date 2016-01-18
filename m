From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 18 Jan 2016 17:20:43 +0900
Subject: [PATCH v4 2/2] power: add documentation for ACT8945A's charger DT
 bindings
In-Reply-To: <1452659289-30837-3-git-send-email-wenyou.yang@atmel.com>
References: <1452659289-30837-1-git-send-email-wenyou.yang@atmel.com>
 <1452659289-30837-3-git-send-email-wenyou.yang@atmel.com>
Message-ID: <569CA05B.3010107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.01.2016 13:28, Wenyou Yang wrote:
> This patch adds documentation for the DT bindings of the charger
> subdevice of ACT8945A MFD.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
> Changes in v4:
>  - change the properties with more legible name, clearer description.
> 
> Changes in v3: None
> Changes in v2: None
> 
>  .../devicetree/bindings/power/act8945a-charger.txt |   33 ++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/act8945a-charger.txt
> 

Okay for me:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
