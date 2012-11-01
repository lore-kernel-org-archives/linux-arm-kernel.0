From: mpn@google.com (Michal Nazarewicz)
Date: Thu, 01 Nov 2012 17:29:38 +0100
Subject: [PATCH 1/6] arch: Change defconfigs to point to g_mass_storage.
In-Reply-To: <Pine.LNX.4.44L0.1211011033170.1762-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1211011033170.1762-100000@iolanthe.rowland.org>
Message-ID: <xa1tobjhwakt.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed, 31 Oct 2012, Michal Nazarewicz wrote:
>> --- a/arch/arm/configs/qil-a9260_defconfig
>> +++ b/arch/arm/configs/qil-a9260_defconfig
>> @@ -108,7 +108,6 @@ CONFIG_ROOT_NFS=y
>>  CONFIG_NLS_CODEPAGE_437=y
>>  CONFIG_NLS_CODEPAGE_850=y
>>  CONFIG_NLS_ISO8859_1=y
>> -CONFIG_DEBUG_KERNEL=y
>>  CONFIG_DEBUG_USER=y
>>  CONFIG_DEBUG_LL=y
>>  # CONFIG_CRYPTO_HW is not set

On Thu, Nov 01 2012, Alan Stern wrote:
> This seems to have crept in by mistake.

Yes, obviously, thanks!

I have updated version prepared, will send it tomorrow in case someone
have some more comments.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 835 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121101/92bca589/attachment.sig>
