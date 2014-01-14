From: monstr@monstr.eu (Michal Simek)
Date: Tue, 14 Jan 2014 13:48:01 +0100
Subject: [PATCH v1 0/24] Zynq DT changes
In-Reply-To: <20140114130801.0f4ea12b@lilith>
References: <cover.1388743861.git.michal.simek@xilinx.com>
 <20140114130801.0f4ea12b@lilith>
Message-ID: <52D53201.1060602@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Albert,

On 01/14/2014 01:08 PM, Albert ARIBAUD wrote:
> Hi Michal,
> 
> On Fri,  3 Jan 2014 11:10:45 +0100, Michal Simek
> <michal.simek@xilinx.com> wrote:
> 
>> Hi,
>>
>> this is respin of Jagan v3 series sent here
>> http://lists.denx.de/pipermail/u-boot/2013-December/169617.html
>> + 2 patches v4
>> http://lists.denx.de/pipermail/u-boot/2013-December/169753.html
>> http://lists.denx.de/pipermail/u-boot/2013-December/169752.html
>>
>> The purpose of this series was to synchronized configuration
>> which we are using with mainline version with adding features
>> which we are using.
>>
>> The major change, which I have done, is adding DT support for
>> all zynq boards instead of board specification configurations.
>> I have changed serial, gem, emaclite, mmc.
>> i2c, spi already support bus selection.
>>
>> For more information please look at patches.
>>
>> All series are available here for easier testing.
>> http://git.denx.de/?p=u-boot/u-boot-microblaze.git;a=shortlog;h=refs/heads/zynq
>>
>> Thanks,
>> Michal
> 
> As Jagan's series has been pulled in, can you resubmit a v2 based on
> current ARM ToT?

yes. That was my plan.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140114/6bfe4347/attachment-0001.sig>
