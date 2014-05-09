From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Fri, 9 May 2014 12:39:35 +0530
Subject: [PATCH v2] ARM: configs: drop CONFIG_COMMON_CLK_DEBUG
In-Reply-To: <536BDB88.8090106@ti.com>
References: <1398755224-7530-1-git-send-email-prabhakar.csengg@gmail.com>
 <536BDB88.8090106@ti.com>
Message-ID: <CA+V-a8s_vjvcX_BpLeg0tnBQx4+n2voQo_dz+EA_ZETTV_exyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On Fri, May 9, 2014 at 1:01 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On Tuesday 29 April 2014 03:07 AM, Lad Prabhakar wrote:
>> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>>
>> this patch removes COMMON_CLK_DEBUG config option
>> from defconfig file as this config option is obsolete.
>>
>> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>> ---
>>  Changes for v2:
>>  a> Dropped imx defconfig files as suggested by Shawn.
>>
>
>>  arch/arm/configs/keystone_defconfig     |    1 -
> Am picking the keystone part from this patch. Thanks.
> You might want split this patch so that others can pick it
> up
>
Thanks for picking it up.

Thanks,
--Prabhakar Lad
