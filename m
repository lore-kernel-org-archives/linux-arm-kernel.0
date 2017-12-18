From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 18 Dec 2017 09:50:10 +0000
Subject: [RESEND PATCH v2 01/15] dt-bindings: soc: qcom: Add bindings for
 APR bus
In-Reply-To: <20171216172722.avtipt5evmreayyc@rob-hp-laptop>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-2-srinivas.kandagatla@linaro.org>
 <20171216172722.avtipt5evmreayyc@rob-hp-laptop>
Message-ID: <fc2f138a-0584-c40c-0547-0015aece738c@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/12/17 17:27, Rob Herring wrote:
> On Thu, Dec 14, 2017 at 05:33:48PM +0000, srinivas.kandagatla at linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch add dt bindings for Qualcomm APR bus driver
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../devicetree/bindings/soc/qcom/qcom,apr.txt      | 28 ++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>> new file mode 100644
>> index 000000000000..4e93213ae98d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>> @@ -0,0 +1,28 @@
>> +Qualcomm APR (Asynchronous Packet Router) binding
>> +
>> +This binding describes the Qualcomm APR. APR is a IPC protocol for
>> +communication between Application processor and QDSP. APR is mainly
>> +used for audio/voice services on the QDSP.
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qcom,apr-<SOC-NAME>" example: "qcom,apr-msm8996"
> 
> <soc>-apr is the more standard order. With that,
Yes, it makes sense, will do that in next version.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for reviewed-by tag.

Rgrds,
Srini
> 
