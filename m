From: rob.herring@calxeda.com (Rob Herring)
Date: Fri, 07 Dec 2012 07:25:10 -0600
Subject: [PATCH v2] ARM: Kconfig: Do not force selection of ARCH_VEXPRESS
 by ARCH_MULTI_V7
In-Reply-To: <CAOMZO5CQZbRub5ZWHzsNfewcRh5T7pPQuKNaTDYaFg-j1HzN0A@mail.gmail.com>
References: <1353431918-9326-1-git-send-email-festevam@gmail.com>
 <CAOMZO5CQZbRub5ZWHzsNfewcRh5T7pPQuKNaTDYaFg-j1HzN0A@mail.gmail.com>
Message-ID: <50C1EE36.6000202@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/2012 04:07 AM, Fabio Estevam wrote:
> Hi Rob,
> 
> On Tue, Nov 20, 2012 at 3:18 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> When building a kernel using imx_v6_v7_defconfig, it is not possible to unselect
>> ARCH_VEXPRESS due to the fact that it is automatically selected by ARCH_MULTI_V7.
>>
>> This is not good when someone wants to create a minimal kernel build, so let
>> multi_v7_defconfig select ARCH_VEXPRESS instead.
>>
>> Also avoid build breakage when randconfig selects no platform.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>> Changes since v1:
>> - Avoid build breakage on randconfig for the case that no platform is selected.
> 
> Does this version look good?

Yes.

Acked-by: Rob Herring <rob.herring@calxeda.com>

> 
> Regards,
> 
> Fabio Estevam
> 
