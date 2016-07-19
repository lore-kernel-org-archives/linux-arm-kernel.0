From: kvalo@codeaurora.org (Kalle Valo)
Date: Tue, 19 Jul 2016 21:07:42 +0300
Subject: [PATCH v2 05/11] Kbuild: don't add obj tree in additional includes
In-Reply-To: <3906958.MrNt71DzrU@wuerfel> (Arnd Bergmann's message of "Tue, 19
 Jul 2016 17:38:51 +0200")
References: <20160615154553.3177021-1-arnd@arndb.de>
 <21521763.EfAflxWUP8@wuerfel> <87a8hdae9j.fsf@purkki.adurom.net>
 <3906958.MrNt71DzrU@wuerfel>
Message-ID: <8760s1v6vl.fsf@kamboji.qca.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

>> > I think that's fine, a couple were already picked up, and what I have
>> > left now is
>> >
>> > a281bfa5713a [SUBMITTED 20160615] [EXPERIMENTAL] Kbuild: enable -Wmissing-include-dirs by default
>> > 83934921e68e [SUBMITTED 20160615] rtlwifi: don't add include path for rtl8188ee
>> 
>> Apparently[1] you didn't CC linux-wireless and that's why I didn't see
>> the rtlwifi patch in wireless patchwork. Care to resend?
>> 
>> [1] https://patchwork.kernel.org/patch/9178861/
>> 
>
> Done.

Thanks.

> I've also thrown in two patches for drivers/staging/rtl8*/ that I
> submitted a while ago, but I'm not sure if they should get merged
> through the staging tree or the wireless tree. I had previously
> submitted those two as a combined patch along with a third one that
> turned out to be unnecessary.

Greg applies drivers/staging patches to his staging tree, but I'll take
the rtlwifi patch.

-- 
Kalle Valo
