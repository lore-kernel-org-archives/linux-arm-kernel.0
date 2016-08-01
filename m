From: rogerq@ti.com (Roger Quadros)
Date: Mon, 1 Aug 2016 11:51:17 +0300
Subject: [GIT PULL] omap-gpmc changes for v4.8 merge window
In-Reply-To: <20160705052111.GO1669@localhost>
References: <5770E51B.8040206@ti.com> <20160705052111.GO1669@localhost>
Message-ID: <edc2a5dc-c831-b05a-5745-c1e361441b41@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/16 08:21, Olof Johansson wrote:
> On Mon, Jun 27, 2016 at 11:34:35AM +0300, Roger Quadros wrote:
>> Hi Arnd/Olof,
>>
>> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
>>
>>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
>>
>> are available in the git repository at:
>>
>>   https://github.com/rogerq/linux.git gpmc-omap-for-v4.8
>>
>> for you to fetch changes up to 32dd625a9f3541ee6d390f12f810f28531d016c7:
>>
>>   memory: omap-gpmc: Move gpio functions out of #ifdef CONFIG_OF (2016-06-17 10:26:48 +0300)
>>
>> ----------------------------------------------------------------
>> OMAP-GPMC: driver updates for v4.8
>>
>> * Make GPMC driver non modular as it is going to
>> be built-in only till arch/arm/mach-omap2 users
>> are removed.
>>
>> * Fix build if CONFIG_OF is not defined.
> 
> Merged into next/drivers.
> 
>>
>> ----------------------------------------------------------------
>> Paul Gortmaker (1):
>>       memory: omap-gpmc: make it explicitly non-modular
>>
>> Roger Quadros (1):
>>       memory: omap-gpmc: Move gpio functions out of #ifdef CONFIG_OF
>>
>>  drivers/memory/omap-gpmc.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------------
> 
> Tip for the future: If you redirect the output through cat, you get the
> diffstat at 80 character lines.

Thanks :).

cheers,
-roger
