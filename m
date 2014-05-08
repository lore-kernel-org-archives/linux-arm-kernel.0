From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 08 May 2014 17:54:35 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0gQVJNOiBkdHM6IGlteDY6IGFkZCBuZXcgYm9hcmQg?=
 =?UTF-8?B?UklvVGJvYXJk?=
In-Reply-To: <CAOMZO5AMf74btETX9zM97B-rCRAVh9-s=N4=xqTMifuucwqURg@mail.gmail.com>
References: <53695C34.5000604@gmail.com> <536B4ACD.30001@gmail.com>
 <CAOMZO5AMf74btETX9zM97B-rCRAVh9-s=N4=xqTMifuucwqURg@mail.gmail.com>
Message-ID: <1399557275.583926987@f142.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thu, 8 May 2014 10:45:39 -0300 ?? Fabio Estevam <festevam@gmail.com>:
> On Thu, May 8, 2014 at 6:13 AM, Iain Paton <ipaton0@gmail.com> wrote:
> > add element14s RIoTboard http://www.riotboard.org which is an i.MX6Solo
> > based design targeted at makers.
> >
> > Signed-off-by: Iain Paton<ipaton0@gmail.com>
> 
> Looks good. One comment only:
> 
> 
> > +&i2c4 {
> > +       clock-frequency = <100000>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_i2c4>;
> > +       clocks = <&clks 116>;
> 
> You could remove this 'clocks' line.

As well as "clock-frequency", since 100 kHz is default value.

---
