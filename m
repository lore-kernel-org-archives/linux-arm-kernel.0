From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 Sep 2015 17:23:41 +0100
Subject: [PATCH v2 4/7] hwrng: st: Provide DT bindings for ST's Random
 Number Generator
In-Reply-To: <55FC3A11.6080209@codeaurora.org>
References: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
 <1442497557-9271-5-git-send-email-lee.jones@linaro.org>
 <55FC3A11.6080209@codeaurora.org>
Message-ID: <CAF2Aj3gBn=PLB=4NvnZwbdtzkYT6QcPPrk3NCNz1+Cx9ZBWr1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 September 2015 at 17:21, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 09/17/2015 06:45 AM, Lee Jones wrote:
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/rng/st,rng.txt | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/rng/st,rng.txt
>>
>> diff --git a/Documentation/devicetree/bindings/rng/st,rng.txt b/Documentation/devicetree/bindings/rng/st,rng.txt
>> new file mode 100644
>> index 0000000..dbc64e6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rng/st,rng.txt
>> @@ -0,0 +1,15 @@
>> +STMicroelectronics HW Random Number Generator
>> +----------------------------------------------
>> +
>> +Required parameters:
>> +compatible   : Should be "st,rng"
>> +reg          : Base address and size of IP's register map.
>> +clocks               : Phandle to device's clock (See: ../clocks/clock-bindings.txt)
>> +
>> +Example:
>> +
>> +rng at 0xfee80000 {
>
> Drop the 0x part please.

Good spot.  Will fix as a subsequent patch.

-- 
Lee Jones
Linaro ST Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
