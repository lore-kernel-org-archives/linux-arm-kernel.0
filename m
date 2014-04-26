From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 26 Apr 2014 23:15:10 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCA4LzhdIEFSTTogZHRzOiBpbXgyNy1waHl0ZWMtcGh5Y29y?=
 =?UTF-8?B?ZS0qOiBNb3ZlICJpb211eCIgbm9kZSB0byB0aGUgYm90dG9tIG9mIGZpbGU=?=
In-Reply-To: <20140426190935.GE5858@pengutronix.de>
References: <1398487933-5683-1-git-send-email-shc_work@mail.ru>
 <1398487933-5683-8-git-send-email-shc_work@mail.ru>
 <20140426190935.GE5858@pengutronix.de>
Message-ID: <1398539710.4978394@f317.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sat, 26 Apr 2014 21:09:35 +0200 ?? Sascha Hauer <s.hauer@pengutronix.de>:
> On Sat, Apr 26, 2014 at 08:52:13AM +0400, Alexander Shiyan wrote:
> > This patch moves "iomux" node to the bottom of file.
> > No functional changes.
> 
> Why? The nodes are (at least should be) sorted alphabetically.

Pin definitions look better in one place, at the bottom.
As far as I know, Shawn supported this position.

---
