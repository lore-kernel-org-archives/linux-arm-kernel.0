From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 03 Jul 2013 12:18:06 +0400
Subject: =?UTF-8?B?UHJvcG9zYWw6IG1hY2gtZHQ=?=
Message-ID: <1372839486.487159774@f54.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

More and more platforms are now using devicetree.
Ideally the platform code contains only one function "of_platform_populate".
My idea is to make a generic architecture (mach-dt) with the call then add support
for compatible subarchitectures as they become available in "compatible"-property.
Your opinion?
Thanks.

---
