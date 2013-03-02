From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 02 Mar 2013 16:00:44 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCAxLzRdIEFSTTogczNjMjR4eDogUmVtb3ZlZCB1bm5l?=
 =?UTF-8?B?ZWRlZCBkZXBlbmRlbmN5IG9uIEFSQ0hfUzNDMjRYWCBmb3IgYm9hcmRz?=
In-Reply-To: <201303021143.38390.arnd@arndb.de>
References: <1362216174-10478-1-git-send-email-shc_work@mail.ru>
 <201303021143.38390.arnd@arndb.de>
Message-ID: <1362225644.599345374@f82.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Saturday 02 March 2013, Alexander Shiyan wrote:
> > Board options are already under "if ARCH_S3C24XX" condition, so
> > additional dependencies on this symbol can be removed.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> 
> Hi Alexander,
> 
> Is this just a cosmetic change that has no other consequences, or do you
> have other follow-up patches that depend on patches 1-3?

Hello Arnd.
Nothing more yet. Perhaps I'll do a merging some parts of the code for
different versions of the CPU into one unit and some future changes
may remove some Kconfig symbols, so it is only initial Kconfig cleaning.
Thanks.

---
