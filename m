From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 23 Apr 2014 22:42:34 +0400
Subject: =?UTF-8?B?UmU6IFNEIENSQyBlcnJvciBvbiBteDI3cGRr?=
In-Reply-To: <CAOMZO5CWLH=ZbUd9dyTqtNVqu0RTSMeBGReBYetO-wzxayS7qw@mail.gmail.com>
References: <CAOMZO5AZ4gJZMo-DZRPffaF+NdzmzMf32YwPu2gEp9AH8gDk4Q@mail.gmail.com>
 <CAOMZO5CWLH=ZbUd9dyTqtNVqu0RTSMeBGReBYetO-wzxayS7qw@mail.gmail.com>
Message-ID: <1398278554.472691404@f213.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wed, 23 Apr 2014 12:21:39 -0300 ?? Fabio Estevam <festevam@gmail.com>:
> On Wed, Apr 23, 2014 at 12:10 PM, Fabio Estevam <festevam@gmail.com> wrote:
> 
> > ,but I get this error:
> >
> > mxc-mmc 10013000.sdhci: mxcmci_finish_data: -EILSEQ
> > mmc0: error -84 whilst initialising SD card
> > mmc0: host does not support reading read-only switch. assuming write-enable.
> > mmc0: new SDHC card at address b5a1
> > mmcblk0: mmc0:b5a1 SD04G 3.69 GiB
> >  mmcblk0: unknown partition table
> 
> I forgot to mention that this error does not happen if I boot the
> non-dt kernel, so it seems to be related to dt only.

Probably you should also use vmmc*_reg voltages from PMIC?

---
