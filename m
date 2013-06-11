From: zhangfei.gao@linaro.org (zhangfei)
Date: Tue, 11 Jun 2013 10:13:57 +0800
Subject: [PATCH v2 2/2] i2c: designware: add two optional property
 tx/rx-fifo-size
In-Reply-To: <20130610184954.GK4312@tarshish>
References: <1370840576-15651-1-git-send-email-zhangfei.gao@linaro.org>
 <1370840576-15651-3-git-send-email-zhangfei.gao@linaro.org>
 <20130610184954.GK4312@tarshish>
Message-ID: <51B687E5.307@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-06-11 02:49 AM, Baruch Siach wrote:
> Hi Zhangfei Gao,
>
> On Mon, Jun 10, 2013 at 01:02:55PM +0800, Zhangfei Gao wrote:
>> rx-fifo-size and tx-fifo-size will be updated if provided from dts
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> CC: Baruch Siach <baruch@tkos.co.il>
>> ---
>>   .../devicetree/bindings/i2c/i2c-designware.txt     |    7 +++++++
>>   drivers/i2c/busses/i2c-designware-platdrv.c        |    3 +++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
>> index e42a2ee..61fdb44 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
>> @@ -6,6 +6,11 @@ Required properties :
>>    - reg : Offset and length of the register set for the device
>>    - interrupts : <IRQ> where IRQ is the interrupt number.
>>
>> +Optional properties:
>> +
>> + - rx-fifo-size : 1 cell, Rx fifo threshold
>
> I'd use the word 'size' instead of 'threshold' here. The term 'threshold' is
> used for something else in the datasheet.
>
> baruch
>
OK, will update and resend the patch.
