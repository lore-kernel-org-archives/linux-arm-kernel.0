From: robherring2@gmail.com (Rob Herring)
Date: Wed, 21 May 2014 10:34:18 -0500
Subject: [PATCH 07/10] dt/bindings: arm-boards: add binding for Versatile
 core module
In-Reply-To: <7810339.hMuUdCPTp0@wuerfel>
References: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
 <1400620176-7239-8-git-send-email-robherring2@gmail.com>
 <7810339.hMuUdCPTp0@wuerfel>
Message-ID: <CAL_JsqJTuMu4jz5t39gSt+DQieVkrvCUNyrp01yGqW_+17uQtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014 at 3:24 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 20 May 2014 16:09:33 Rob Herring wrote:
>> diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
>> index 3509707..3a950d9 100644
>> --- a/Documentation/devicetree/bindings/arm/arm-boards
>> +++ b/Documentation/devicetree/bindings/arm/arm-boards
>> @@ -86,3 +86,9 @@ Interrupt controllers:
>>         compatible = "arm,versatile-sic";
>>         interrupt-controller;
>>         #interrupt-cells = <1>;
>> +
>> +Required nodes:
>> +
>> +- core-module: the root node to the Versatile platforms must have
>> +  a core-module with regs and the compatible string
>> +  "arm,core-module-versatile"
>>
>
>
> Should we mark this compatible="syscon" as well, so we can move
> the accesses into syscon references later if we want to?

Yes, probably so. That should be done on Integrator and Realview as
well if not already.

Rob
