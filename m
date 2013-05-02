From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 02 May 2013 08:13:44 +0400
Subject: =?UTF-8?B?UmVbM106IFtQQVRDSCAzLzNdIEFSTTogZHRzOiBBZGQgTUMxMzc4MyBzdXBw?=
 =?UTF-8?B?b3J0IGZvciBpLk1YMjcgUGh5dGVjIFBDTTAzOCBtb2R1bGU=?=
In-Reply-To: <1367467798.105341722@f164.mail.ru>
References: <1367405219-19078-1-git-send-email-shc_work@mail.ru>
 <20130501191528.GB31135@pengutronix.de>
 <1367467798.105341722@f164.mail.ru>
Message-ID: <1367468024.851006021@f164.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > On Wed, May 01, 2013 at 07:40:37PM +0400, Alexander Shiyan wrote:
> > > > On Wed, May 01, 2013 at 02:46:59PM +0400, Alexander Shiyan wrote:
> > > > > Added MC13783 node to imx27-phytec-phycore DT file.
> > > > > 
> > > > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > > > ---
> > > > >  arch/arm/boot/dts/imx27-phytec-phycore.dts | 92 ++++++++++++++++++++++++++++++
> > > > >  1 file changed, 92 insertions(+)
> > > > 
> > > > You can merge this with the previous patch.
> > > 
> > > Part 2 just adds a SPI host for the target. Is this merge is really necessary?
> > 
> > The SPI host does nothing without devices registered on it, so why not
> > make 2/3 and 3/3 a single patch?
> 
> At point of 2/3 user can use SPI0.0 as spidev. And in th

Please ignore this message.
Thanks.

---
