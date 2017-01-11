From: s-anna@ti.com (Suman Anna)
Date: Wed, 11 Jan 2017 15:49:28 -0600
Subject: [PATCH] Documentation: dt: reset: Revise typos in TI syscon reset
 example
In-Reply-To: <20170111211520.w3sy5pkvjydiwvcs@rob-hp-laptop>
References: <20170109192814.26811-1-s-anna@ti.com>
 <20170111211520.w3sy5pkvjydiwvcs@rob-hp-laptop>
Message-ID: <5fa2bd27-5356-1f2f-8f92-3d0d3dcaa2b4@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2017 03:15 PM, Rob Herring wrote:
> On Mon, Jan 09, 2017 at 01:28:14PM -0600, Suman Anna wrote:
>> Fix couple of typos in the example given in the TI syscon reset
>> binding. The ti,reset-bits used for DSP0 are corrected to match
>> the values that will be used in the actual DT node.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>> Hi Philipp,
>>
>> This is the Documentation part fix that goes along with
>> the ti-syscon-reset fix that you have on your next branch.
>> I will be submitting the DT nodes very soon
>>
>> regards
>> Suman
>>
>>  Documentation/devicetree/bindings/reset/ti-syscon-reset.txt | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt b/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
>> index 164c7f34c451..21ba739b162e 100644
>> --- a/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
>> +++ b/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
>> @@ -63,7 +63,7 @@ Example:
>>  --------
>>  The following example demonstrates a syscon node, the reset controller node
>>  using the syscon node, and a consumer (a DSP device) on the TI Keystone 2
>> -Edison SoC.
>> +66AK2E SoC.
>>  
>>  / {
>>  	soc {
>> @@ -71,13 +71,13 @@ Edison SoC.
>>  			compatible = "syscon", "simple-mfd";
>>  			reg = <0x02350000 0x1000>;
>>  
>> -			pscrst: psc-reset {
>> +			pscrst: psc-reset-controller {
> 
> Really, this should be just 'reset-controller'.

Thanks Rob, I will fix this patch and the DTS patches as well.

regards
Suman
