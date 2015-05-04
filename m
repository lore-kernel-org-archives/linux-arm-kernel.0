From: stripathi@apm.com (Suman Tripathi)
Date: Mon, 4 May 2015 11:33:17 +0530
Subject: [PATCH v3 3/3] Documentation: mmc: Update Arasan SDHC
 documentation to support 4.9a version of Arasan SDHC controller.
In-Reply-To: <f442e594-ac5c-4e77-ab80-3055fb791066@BN1AFFO11FD021.protection.gbl>
References: <1430456052-8888-1-git-send-email-stripathi@apm.com>
 <1430456052-8888-4-git-send-email-stripathi@apm.com>
 <f442e594-ac5c-4e77-ab80-3055fb791066@BN1AFFO11FD021.protection.gbl>
Message-ID: <CAOHikRBbOYHOmnzA6Ycu6hwdNL6SgmXKVK0NLtJQfJL9KULuxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 4, 2015 at 11:30 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 05/01/2015 06:54 AM, Suman Tripathi wrote:
>> This patch updates Arasan SDHC documentation to support
>> 4.9a version of Arasan SDHC controller.
>>
>> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> index 98ee2ab..f01d41a 100644
>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> @@ -8,7 +8,8 @@ Device Tree Bindings for the Arasan SDHCI Controller
>>    [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>>
>>  Required Properties:
>> -  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
>> +  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
>> +                'arasan,sdhci-4.9a'
>>    - reg: From mmc bindings: Register location and length.
>>    - clocks: From clock bindings: Handles to clock inputs.
>>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
>> @@ -18,7 +19,7 @@ Required Properties:
>>
>>  Example:
>>       sdhci at e0100000 {
>> -             compatible = "arasan,sdhci-8.9a";
>> +             compatible = "arasan,sdhci-8.9a", "arasan,sdhci-4.9a";
>
> Is there any reason to change this example?

Thought that if dts is updated so why not update the binding too.

> You probably want to have just one compatible string not both.

Okay will remove in next version.

>
> Thanks,
> Michal
>
>
>
>



-- 
Thanks,
with regards,
Suman Tripathi
