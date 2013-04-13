From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 13 Apr 2013 13:18:31 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSF0gbW1jOiBteGNtbWM6IEZpeCBidWcgd2hlbiBjYXJk?=
 =?UTF-8?B?IGlzIHByZXNlbnQgZHVyaW5nIGJvb3Q=?=
In-Reply-To: <87bo9jfwgn.fsf@octavius.laptop.org>
References: <1365228811-10928-1-git-send-email-shc_work@mail.ru>
 <20130409073318.GF1906@pengutronix.de>
 <87bo9jfwgn.fsf@octavius.laptop.org>
Message-ID: <1365844711.170912126@f179.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi,
> 
> On Tue, Apr 09 2013, Sascha Hauer wrote:
> > On Sat, Apr 06, 2013 at 10:13:31AM +0400, Alexander Shiyan wrote:
> >> This patch fixes bug when card is present during boot.
> >> Bug was introduced due commit "mmc: mxcmmc: fix bug that may block a
> >> data transfer forever". When a card is present "mxcmci_setup_data"
> >> function is executed, but the timer is not initialized.
> >
> > Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Thanks, pushed to mmc-next for 3.10.

OK. What about commit this patch in 3.8 stable?

---
