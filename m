From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 28 Jun 2018 00:02:10 -0300
Subject: [PATCH 1/3] ARM: dts: imx53: Add 'ARM platform' node
In-Reply-To: <20180628013530.GE22683@dragon>
References: <1529329939-14117-1-git-send-email-festevam@gmail.com>
 <20180628013530.GE22683@dragon>
Message-ID: <CAOMZO5CQCTdJC5NOzFGXeHwqkeJmrw9ui0oJ_h=7vFnP5ThUcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 10:35 PM, Shawn Guo <shawnguo@kernel.org> wrote:

>> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
>> index 1a7a7bb..a70fbf4 100644
>> --- a/arch/arm/boot/dts/imx53.dtsi
>> +++ b/arch/arm/boot/dts/imx53.dtsi
>> @@ -672,6 +672,11 @@
>>                               status = "disabled";
>>                       };
>>
>> +                     arm_platform: arm-platform at 63fa0000 {
>> +                             compatible = "fsl,imx53-arm-plat", "fsl,imx51-arm-plat";
>
> Don't we need a bindings for that?

I thought this is the same case as "fsl,imx51-src" where we only use
it inside arch/arm/mach-imx/ and there is also no bindings doc for it.

That's why I did not add an entry for the bindings doc.

If you think that a binding doc is needed, in which directory should
it be placed?
