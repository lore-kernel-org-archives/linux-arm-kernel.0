From: marex@denx.de (Marek Vasut)
Date: Tue, 11 Dec 2012 00:22:43 +0100
Subject: [PATCH 3/4] iio: mxs: Implement support for touchscreen
In-Reply-To: <20121210222437.GA19008@core.coreip.homeip.net>
References: <1354893893-26338-1-git-send-email-marex@denx.de>
 <50C312D8.4050405@kernel.org> <20121210222437.GA19008@core.coreip.homeip.net>
Message-ID: <201212110022.44181.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Dmitry Torokhov,

> Hi Marek, Jonathan,
> 
> On Sat, Dec 08, 2012 at 10:13:44AM +0000, Jonathan Cameron wrote:
> > On 12/07/2012 03:24 PM, Marek Vasut wrote:
> > > This patch implements support for sampling of a touchscreen into
> > > the MXS LRADC driver. The LRADC block allows configuring some of
> > > it's channels into special mode where they either output the drive
> > > voltage or sample it, allowing it to operate a 4-wire or 5-wire
> > > resistive touchscreen.
[...]

All of these are nice catches, thanks!

Best regards,
Marek Vasut
