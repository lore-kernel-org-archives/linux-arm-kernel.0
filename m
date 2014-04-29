From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Tue, 29 Apr 2014 11:49:35 +0530
Subject: [PATCH] ARM: configs: drop CONFIG_COMMON_CLK_DEBUG
In-Reply-To: <20140429061417.GJ16451@dragon>
References: <1398504922-9223-1-git-send-email-prabhakar.csengg@gmail.com>
 <20140429061417.GJ16451@dragon>
Message-ID: <CA+V-a8vnha1Pk7pJ0nRizk=A+b-w_bAyS6E+32dPimSBCMg-Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 11:44 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Sat, Apr 26, 2014 at 03:05:22PM +0530, Lad Prabhakar wrote:
>> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>>
>> this patch removes COMMON_CLK_DEBUG config option
>> from defconfig file as this config option is obsolete.
>>
>> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>> ---
>>  arch/arm/configs/imx_v4_v5_defconfig    |    1 -
>>  arch/arm/configs/imx_v6_v7_defconfig    |    1 -
> ...
>>  arch/arm/configs/mxs_defconfig          |    1 -
>
> Please drop these 3 files from your patch.  The obsolete
> COMMON_CLK_DEBUG option has been removed from two of them on my branch
> by savedefconfig, and we will address the remaining one in another
> patch.
>
OK will post the updated patch dropping these 3 files.

Regards,
--Prabhakar Lad
