From: monstr@monstr.eu (Michal Simek)
Date: Thu, 22 May 2014 06:58:43 +0200
Subject: [PATCH] i2c: cadence: fix Kconfig dependency
In-Reply-To: <78a702ca-5001-444a-b2df-a64de17ffcb6@BY2FFO11FD039.protection.gbl>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
 <1396852656.682914397@f273.i.mail.ru> <20140407065657.GO29751@pengutronix.de>
 <1396854155.872298456@f287.i.mail.ru>
 <4c4d2ba5-f5f6-4589-8a48-6a88d1c16098@VA3EHSMHS046.ehs.local>
 <20140521082917.GG2708@katana>
 <78a702ca-5001-444a-b2df-a64de17ffcb6@BY2FFO11FD039.protection.gbl>
Message-ID: <537D8403.60400@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2014 06:00 PM, S?ren Brinkmann wrote:
> Hi Wolfram,
> 
> On Wed, 2014-05-21 at 10:29AM +0200, Wolfram Sang wrote:
>>> I'd propose the below fix. The relaxed IO helpers are currently
>>> available on ARM only and the clock notifier used, depends on
>>> COMMON_CLK. I2C-related dependencies should be okay due to the location in
>>> Kconfig of this option.
>>
>> If somebody thinks an update is still needed, please resend against
>> latest i2c-next. Thanks.
>>
> 
> I think we're fine for now. Once the *_relaxed IO helpers are available
> on all archs it makes sense to revisit the COMPILE_TEST option. Until
> then we are restricted to ARM anyway and the additional Zynq restriction
> doesn't make a big difference, IMHO.
> 
> @Michal: Do you have an update on the IO helpers?

My patch was replaced by Will's one but I can't see it in linux-next
that's why we should ask directly Will.
Will: What's the status on it?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140522/036b8ba4/attachment.sig>
