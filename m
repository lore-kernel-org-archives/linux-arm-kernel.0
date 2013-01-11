From: marex@denx.de (Marek Vasut)
Date: Sat, 12 Jan 2013 00:36:03 +0100
Subject: [PATCH 1/2 V3] iio: mxs: Implement support for touchscreen
In-Reply-To: <20130111165420.GA11224@core.coreip.homeip.net>
References: <1357861431-8978-1-git-send-email-marex@denx.de>
 <20130111165420.GA11224@core.coreip.homeip.net>
Message-ID: <201301120036.03499.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

> Hi Marek,
> 
> On Fri, Jan 11, 2013 at 12:43:50AM +0100, Marek Vasut wrote:
> > This patch implements support for sampling of a touchscreen into
> > the MXS LRADC driver. The LRADC block allows configuring some of
> > it's channels into special mode where they either output the drive
> > voltage or sample it, allowing it to operate a 4-wire or 5-wire
> > resistive touchscreen.

[...]

> Besides the minor nits above,
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Thanks!

Fixed the issues and rolled V4. Thank you for the reviews and the help!

Best regards,
Marek Vasut
