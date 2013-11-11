From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 11 Nov 2013 12:15:06 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzVdIEFSTTogZHRzOiBpLk1YNTE6IE1vdmUgdXNicGh5?=
 =?UTF-8?B?MCBub2RlIGZyb20gQUlQUzE=?=
In-Reply-To: <20131111081148.GA11083@S2101-09.ap.freescale.net>
References: <1383813908-26571-1-git-send-email-shc_work@mail.ru>
 <20131111081148.GA11083@S2101-09.ap.freescale.net>
Message-ID: <1384157706.39361830@f119.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, Nov 07, 2013 at 12:45:04PM +0400, Alexander Shiyan wrote:
> > usbphy0 is not a part of AIPS1, so move this node under usbotg.
> > Additionally this patch removes useless "status" property.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> 
> Applied all except #4.  I would add those pingroups only when there are
> in-tree users of it.

Please revert this one part too [1/5]. This change is incorrect. I will make
other solution later.
Thanks.

---
