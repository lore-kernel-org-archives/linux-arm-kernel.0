From: monstr@monstr.eu (Michal Simek)
Date: Mon, 07 Apr 2014 08:02:23 +0200
Subject: [PATCH 06/10] ARM: EXYNOS: Add support for mapping PMU base
 address via DT
In-Reply-To: <533FE1BC.7050300@samsung.com>
References: <1396425058-4012-1-git-send-email-pankaj.dubey@samsung.com>
 <1396425058-4012-7-git-send-email-pankaj.dubey@samsung.com>
 <533BF905.6070701@samsung.com> <533BFF69.1060701@monstr.eu>
 <533D24D6.2030103@samsung.com> <533FE1BC.7050300@samsung.com>
Message-ID: <53423F6F.5010504@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2014 12:58 PM, Pankaj Dubey wrote:
> On 04/03/2014 06:07 PM, Sylwester Nawrocki wrote:
>> On 02/04/14 14:15, Michal Simek wrote:
>>>> There were some patches posted for syscon to make it available in earlier
>>>> system initialization stage: https://lkml.org/lkml/2014/2/19/218
>>> I haven't finished this yet. I have to look at it again.
>> Thanks for the information, I assume this would be also useful
>> on the Exynos SoC series, so I'd be happy to see continuation
>> of those works.
> 
> It is useful for Exynos SoC series and I have modified this patch series to use early syscon
> initialization API and I can see it's working.
> I have some observation for early initialization of syscon API which I will
> update in corresponding message thread.

Great. Please update that thread we should finish this implementation
to be useful for everybody.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140407/5cd1bdf7/attachment.sig>
