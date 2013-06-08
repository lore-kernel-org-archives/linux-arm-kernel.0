From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 08 Jun 2013 15:56:46 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCBWMl0gc2VyaWFsOiBpbXg6IGVuYWJsZSB0aGUgY2xv?=
 =?UTF-8?B?Y2tzIG9ubHkgd2hlbiB0aGUgdWFydCBpcyB1c2Vk?=
In-Reply-To: <20130608062307.GB22416@S2101-09.ap.freescale.net>
References: <1370311173-15019-1-git-send-email-b32955@freescale.com>
 <51B2CDAF.3050104@freescale.com>
 <20130608062307.GB22416@S2101-09.ap.freescale.net>
Message-ID: <1370692606.345337886@f164.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sat, Jun 08, 2013 at 02:22:39PM +0800, Huang Shijie wrote:
> > ? 2013?06?08? 14:01, Shawn Guo ??:
> > >Running linux-next 20130607, I just found that the serial console stops
> > >working due to this patch.  I think the clocks need to be enabled for
> > >console as well.
> > could you tell me the board?
> > i tested on imx6q-sabreauto boards, the console is ok.
> 
> imx6q-sabresd

I confirm that console not work correct after this patch on the i.MX27 PCM038 board.

---
