From: mohun106@gmail.com (Radha Mohan)
Date: Tue, 25 Mar 2014 17:00:55 +0530
Subject: [PATCH v2 3/3] Documentation: add devicetree bindings for Cavium
 Thunder SoC
In-Reply-To: <4189666.qlSmlZKNNW@wuerfel>
References: <1395652179-9216-1-git-send-email-mohun106@gmail.com>
 <1395652179-9216-4-git-send-email-mohun106@gmail.com>
 <4189666.qlSmlZKNNW@wuerfel>
Message-ID: <CAC8NTUXBqLbZyBOzq=DZYY4xOMZo0Z4L6VtQUYsmWc2m4onapw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 4:30 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 24 March 2014 14:39:39 mohun106 at gmail.com wrote:
>> diff --git a/Documentation/devicetree/bindings/arm/cavium-thunder.txt b/Documentation/devicetree/bindings/arm/cavium-thunder.txt
>> new file mode 100644
>> index 0000000..6ea0a34
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/cavium-thunder.txt
>> @@ -0,0 +1,9 @@
>> +Cavium Thunder platform device tree bindings
>> +---------------------------------------------
>> +
>> +Boards with Cavium's Thunder SoC shall have following properties.
>> +
>> +Root Node
>> +---------
>> +Required root node properties:
>> +    - compatible = "cavium,thunder";
>> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
>> index 333f4ae..f6cadf1 100644
>> --- a/Documentation/devicetree/bindings/arm/cpus.txt
>> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
>> @@ -163,6 +163,7 @@ nodes to be present and contain the properties described below.
>>                             "arm,cortex-r4"
>>                             "arm,cortex-r5"
>>                             "arm,cortex-r7"
>> +                           "cavium,thunder"
>>                             "faraday,fa526"
>>                             "intel,sa110"
>>                             "intel,sa1100"
>
>
> It seems very confusing to use the same name for both the SoC and the
> CPU core. Can you guarantee that there will never be another SoC with
> the same core, or a different CPU core in a SoC with the same name?
>
> If not, please be more specific here and use the exact model names
> rather than the product names.

OK, will fix this once I discuss this internally.

>
>         Arnd
