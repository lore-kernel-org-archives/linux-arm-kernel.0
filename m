From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 19 May 2016 20:37:39 +0300
Subject: [PATCH v3 3/6] ARM: dts: r8a7794: add MSTP10 clocks
In-Reply-To: <CAMuHMdVjrVFpEZPukWiLQK473R+7CTqVHc1jj8fktAD9RpH_sw@mail.gmail.com>
References: <2378837.cigT3tNQPe@wasted.cogentembedded.com>
 <3321354.LNTkVAhXvF@wasted.cogentembedded.com>
 <CAMuHMdVjrVFpEZPukWiLQK473R+7CTqVHc1jj8fktAD9RpH_sw@mail.gmail.com>
Message-ID: <f0700315-af43-b208-cd91-8ca510bf5da9@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05/19/2016 07:44 PM, Geert Uytterhoeven wrote:

>> Add MSTP10 clocks to the R8A7794 device tree.
>>
>> This patch is based on the commit ee9141522dcf ("ARM: shmobile: r8a7791:
>> add MSTP10 support on DTSI").
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
[...]
>> Index: renesas/include/dt-bindings/clock/r8a7794-clock.h
>> ===================================================================
>> --- renesas.orig/include/dt-bindings/clock/r8a7794-clock.h
>> +++ renesas/include/dt-bindings/clock/r8a7794-clock.h
>> @@ -109,6 +109,34 @@
>>  #define R8A7794_CLK_I2C1               30
>>  #define R8A7794_CLK_I2C0               31
>>
>> +/* MSTP10 */
>> +#define R8A7794_CLK_SSI_ALL            5
>> +#define R8A7794_CLK_SSI9               6
>> +#define R8A7794_CLK_SSI8               7
>> +#define R8A7794_CLK_SSI7               8
>> +#define R8A7794_CLK_SSI6               9
>> +#define R8A7794_CLK_SSI5               10
>> +#define R8A7794_CLK_SSI4               11
>> +#define R8A7794_CLK_SSI3               12
>> +#define R8A7794_CLK_SSI2               13
>> +#define R8A7794_CLK_SSI1               14
>> +#define R8A7794_CLK_SSI0               15
>> +#define R8A7794_CLK_SCU_ALL            17
>> +#define R8A7794_CLK_SCU_DVC1           18
>> +#define R8A7794_CLK_SCU_DVC0           19
>> +#define R8A7794_CLK_SCU_CTU1_MIX1      20
>> +#define R8A7794_CLK_SCU_CTU0_MIX0      21
>> +#define R8A7794_CLK_SCU_SRC9           22
>> +#define R8A7794_CLK_SCU_SRC8           23
>> +#define R8A7794_CLK_SCU_SRC7           24
>
> R-Car E2 does not have SRC7, SRC8, SRC9, ...
>
>> +#define R8A7794_CLK_SCU_SRC6           25
>> +#define R8A7794_CLK_SCU_SRC5           26
>> +#define R8A7794_CLK_SCU_SRC4           27
>> +#define R8A7794_CLK_SCU_SRC3           28
>> +#define R8A7794_CLK_SCU_SRC2           29
>> +#define R8A7794_CLK_SCU_SRC1           30
>> +#define R8A7794_CLK_SCU_SRC0           31
>
> ... and SRC0.

    Yet table 7A.12 in the rev1.02 manual lists them all. Your manual doesn't?

MBR, Sergei
