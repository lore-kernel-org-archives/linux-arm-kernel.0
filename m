From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 19 Aug 2014 19:22:32 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0gQVJNOiBpLk1YOiBkdHM6IEFkZCBzdXBwb3J0IGZv?=
 =?UTF-8?B?ciB0aGUgRnJlZXNjYWxlIGkuTVgxIEFEUyBib2FyZA==?=
In-Reply-To: <CAOMZO5B7oiy0Kuac2wMSMNBAVima+S0OR1rR-9p034S75rBzjg@mail.gmail.com>
References: <1408430027-4326-1-git-send-email-shc_work@mail.ru>
 <CAOMZO5B7oiy0Kuac2wMSMNBAVima+S0OR1rR-9p034S75rBzjg@mail.gmail.com>
Message-ID: <1408461752.186151416@f405.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tue, 19 Aug 2014 10:29:08 -0300 ?? Fabio Estevam <festevam@gmail.com>:
> On Tue, Aug 19, 2014 at 3:33 AM, Alexander Shiyan <shc_work@mail.ru> wrote:
> > This patch adds support for the Freescale (Motorola) i.MX1 ADS board.
> > This change is intended to further remove non-DT support for this board.
> >
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> 
> Looks good, only one minor comment:
> 
> >
> > +&iomuxc {
> > +       imx1-motorola-ads {
> 
> Should be imx1-ads instead.

Ah, yes. Shawn, can this be fixed during apply?

---
