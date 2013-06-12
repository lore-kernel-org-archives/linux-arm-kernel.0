From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 12 Jun 2013 09:56:59 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCB2NCAxLzNdIGxlZHM6IGxlZHMtbWMxMzc4MzogUHJl?=
 =?UTF-8?B?cGFyZSBkcml2ZXIgdG8gc3VwcG9ydCBNQzEzODkyIExFRHM=?=
References: <1370883572-877-1-git-send-email-shc_work@mail.ru>
 <51B6DBE8.5090505@epfl.ch>
Message-ID: <1371016619.568314384@f185.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, Jun 11, 2013 at 1:12 AM, Philippe R?tornaz
> <philippe.retornaz@epfl.ch> wrote:
> > Le 10/06/2013 18:59, Alexander Shiyan a ?crit :
> >
> >> This patch rewrite driver code to be ready to add support for
> >> MC13892 LEDs and probe from devicetree.
> >>
> >> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> >
> >
> >
> > The whole serie:
> >
> > Tested-by: Philippe Retornaz <philippe.retornaz@epfl.ch>
> >
> > On mx31moboard with an mc13783.
> >
> 
> Thanks for testing, did you test device tree as well? I failed to see
> any DTS file adding/change in this patchset.

DT test passed by me on the PCM-970 board (i.MX27 & MC13783).
Non-DT test passed by me on Digi CCWMX51 module (i.MX51 & MC13892).
Thanks.

---
