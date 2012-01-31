From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 31 Jan 2012 09:56:37 +0100
Subject: [GIT PULL] i.MX fixes for -rc
In-Reply-To: <CAOesGMj4k3NcXMh3WtegJgejdDK1QntDnyudD6Ky8Ou6mN3cBg@mail.gmail.com>
References: <20120127111024.GB5446@pengutronix.de>
 <CAOesGMj4k3NcXMh3WtegJgejdDK1QntDnyudD6Ky8Ou6mN3cBg@mail.gmail.com>
Message-ID: <20120131085637.GM1990@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2012 at 02:32:46PM -0800, Olof Johansson wrote:
> Hi,
> 
> On Fri, Jan 27, 2012 at 3:10 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > Fabio Estevam (3):
> > ? ? ?ARM: mx3: Let mx31 and mx35 share the same CCM header file
> > ? ? ?ARM: mx3: Let mx31 and mx35 enter in LPM mode in WFI
> > ? ? ?ARM: imx_v4_v5_defconfig: Fix the selection of 32 bit flash support for iMX21ADS board
> 
> The first two don't seem like fixes to me from a quick glance at them
> -- one is a cleanup, the other is a feature. If they are fixes, please
> help us out by motivating why they should go in during -rc instead of
> in the next merge window. Thanks!

I understood that the second patch is a bugfix and that it depends on
the first one. Fabio, can you comment on this?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
