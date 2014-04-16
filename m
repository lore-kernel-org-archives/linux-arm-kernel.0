From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 16 Apr 2014 16:07:18 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNIGkuTVg1MTogQWRkIEVmaWthIE1YIFNtYXJ0Ym9v?=
 =?UTF-8?B?ayBkZXZpY2V0cmVl?=
In-Reply-To: <87tx9to71v.fsf@lebrac.rtp-net.org>
References: <1397641298-25392-1-git-send-email-shc_work@mail.ru>
 <87tx9to71v.fsf@lebrac.rtp-net.org>
Message-ID: <1397650038.299778344@f431.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wed, 16 Apr 2014 13:19:40 +0200 ?? Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>:
> Alexander Shiyan <shc_work@mail.ru> writes:
> 
> > This patch adds support for Efika MX Smartbook.
> 
> I'm curious, how did you test that ? From a very quick look,
> seems it has no chance to work with the uboot shipped with the devices.

Uboot it is not the only option for booting.
With any loader, this can be used with "appended DTB" option in the kernel.

This board support was be introduced by Sascha Hauer for the "barebox".
So I think he was checking its workability.

---
