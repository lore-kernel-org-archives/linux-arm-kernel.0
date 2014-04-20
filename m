From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 20 Apr 2014 07:58:21 +0400
Subject: =?UTF-8?B?UmU6IFVTQiBPVEcgc3VwcG9ydCBvbiBteDI3cGRr?=
In-Reply-To: <ddc3005702174f55b564328820078fb8@BL2PR03MB226.namprd03.prod.outlook.com>
References: <CAOMZO5BcTP=fvYDE8EU2Y2Syn=QqbPd4zaQ96mSfy-mgLEjOmA@mail.gmail.com>
 <CAOMZO5A1CQP3jLJKs1HJupc8GxXzKMf7czTx21=PxomyENhhTw@mail.gmail.com>
 <ddc3005702174f55b564328820078fb8@BL2PR03MB226.namprd03.prod.outlook.com>
Message-ID: <1397966301.558037781@f362.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sun, 20 Apr 2014 00:48:28 +0000 ?? Peter Chen <Peter.Chen@freescale.com>:
> > -----Original Message-----
> > From: Fabio Estevam [mailto:festevam at gmail.com]
> > Sent: Sunday, April 20, 2014 1:10 AM
> > To: Chen Peter-B29397
> > Cc: Michael Grzeschik; Alexander Shiyan; linux-arm-
> > kernel at lists.infradead.org; linux-usb at vger.kernel.org; Sascha Hauer;
> > chris.ruehl at gtsys.com.hk; Guo Shawn-R65073
> > Subject: Re: USB OTG support on mx27pdk
> > 
> > On Sat, Apr 19, 2014 at 4:32 AM, Peter Chen <Peter.Chen@freescale.com>
> > wrote:
> > > The below patch is intended to fix above issues for all platforms,
> > > I have tested it at imx6 platform, if possible, have a test at
> > imx25/imx27
> > > please.
> > 
> > I don't see any patch below, but anyway I have managed to fix the
> > issue on mx27 at dts level.
> > 
> 
> https://github.com/hzpeterchen/linux-usb/commit/c1f42ea27ed3f5d988c63da7849d2e6b445b4fbc
> 
> Your problem is different with sasche's, which hang the system due to
> no phy clk. The chris's patch should not cause the oops.

For me, nothing has changed.
The driver works on i.MX27 PCM970 RDK with the patch as well as without it.

---
