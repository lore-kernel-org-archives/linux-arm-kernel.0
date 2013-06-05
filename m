From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 05 Jun 2013 15:43:07 +0400
Subject: =?UTF-8?B?UmVbNF06IFtQQVRDSCAxLzJdIGh3bW9uOiBtYzEzNzgzLWFkYzogUmVmYWN0?=
 =?UTF-8?B?b3Igc291cmNlIHRvIGluZGljYXRlIHZhcmlvdXMgbWMxM3h4eCBjaGlwcw==?=
In-Reply-To: <201306051336.49776.arnd@arndb.de>
References: <1370422628-1073-1-git-send-email-shc_work@mail.ru>
 <1370430879.384973987@f91.mail.ru>
 <201306051336.49776.arnd@arndb.de>
Message-ID: <1370432587.906000493@f233.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wednesday 05 June 2013, Alexander Shiyan wrote:
> > Well, let's leave the kconfig symbol as is. But about the rest, that mc13783_*
> > symbols in the log (debug) will say a developer who does not know about
> > mc13892 compatibility with mc13783? I still believe that this should be reflected.
> 
> If the log messages use dev_printk, they will use the correct device name already,
> if not, that can be fixed.
> 
> I agree with Jean: we don't just rename things unless there is a significant
> benefit, which I don't see here. There is also the risk that we need to support
> a different chip named mc13xxx in the future that is different enough to require
> a new driver and then the naming is even more screwed up.

It is a pity that the revision and updating of the code of this driver died.
Well, lets drop thesepatches.
Thanks.

---
