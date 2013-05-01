From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 01 May 2013 19:40:37 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCAzLzNdIEFSTTogZHRzOiBBZGQgTUMxMzc4MyBzdXBw?=
 =?UTF-8?B?b3J0IGZvciBpLk1YMjcgUGh5dGVjIFBDTTAzOCBtb2R1bGU=?=
In-Reply-To: <20130501153609.GA31135@pengutronix.de>
References: <1367405219-19078-1-git-send-email-shc_work@mail.ru>
 <1367405219-19078-3-git-send-email-shc_work@mail.ru>
 <20130501153609.GA31135@pengutronix.de>
Message-ID: <1367422837.138582176@f94.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed, May 01, 2013 at 02:46:59PM +0400, Alexander Shiyan wrote:
> > Added MC13783 node to imx27-phytec-phycore DT file.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  arch/arm/boot/dts/imx27-phytec-phycore.dts | 92 ++++++++++++++++++++++++++++++
> >  1 file changed, 92 insertions(+)
> 
> You can merge this with the previous patch.

Part 2 just adds a SPI host for the target. Is this merge is really necessary?

---
