From: l.stelmach@samsung.com (=?utf-8?Q?=C5=81ukasz?= Stelmach)
Date: Wed, 07 Jan 2015 11:27:25 +0100
Subject: [PATCH] ARM: vexpress_defconfig: enable ACL and security labels
 for ext4
In-Reply-To: <3238168.YKYh95mZKp@wuerfel>
References: <1418383877-29685-1-git-send-email-l.stelmach@samsung.com>
 <3238168.YKYh95mZKp@wuerfel>
Message-ID: <87fvbmubqq.fsf%l.stelmach@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was <2014-12-12 pi? 12:38>, when Arnd Bergmann wrote:
> On Friday 12 December 2014 12:31:17 ?ukasz Stelmach wrote:
>> This patch enables security features of ext4 file-system required
>> by many conteporary user-space setups.
>> 
>> Signed-off-by: ?ukasz Stelmach <l.stelmach@samsung.com>
>> ---
>>  arch/arm/configs/vexpress_defconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>
> The patch looks good, but should be addressed to the vexpress maintainers
> (Liviu, Sudeep, Lorenzo)
>
> 	Arnd

...?
ping?

>> diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
>> index f489fda..1d9dd6e 100644
>> --- a/arch/arm/configs/vexpress_defconfig
>> +++ b/arch/arm/configs/vexpress_defconfig
>> @@ -138,6 +138,8 @@ CONFIG_EXT3_FS=y
>>  # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
>>  # CONFIG_EXT3_FS_XATTR is not set
>>  CONFIG_EXT4_FS=y
>> +CONFIG_EXT4_FS_POSIX_ACL=y
>> +CONFIG_EXT4_FS_SECURITY=y
>>  CONFIG_VFAT_FS=y
>>  CONFIG_TMPFS=y
>>  CONFIG_JFFS2_FS=y

-- 
?ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 489 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150107/1375935f/attachment.sig>
