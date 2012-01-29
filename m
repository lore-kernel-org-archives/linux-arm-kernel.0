From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2012 14:32:46 -0800
Subject: [GIT PULL] i.MX fixes for -rc
In-Reply-To: <20120127111024.GB5446@pengutronix.de>
References: <20120127111024.GB5446@pengutronix.de>
Message-ID: <CAOesGMj4k3NcXMh3WtegJgejdDK1QntDnyudD6Ky8Ou6mN3cBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 27, 2012 at 3:10 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> Fabio Estevam (3):
> ? ? ?ARM: mx3: Let mx31 and mx35 share the same CCM header file
> ? ? ?ARM: mx3: Let mx31 and mx35 enter in LPM mode in WFI
> ? ? ?ARM: imx_v4_v5_defconfig: Fix the selection of 32 bit flash support for iMX21ADS board

The first two don't seem like fixes to me from a quick glance at them
-- one is a cleanup, the other is a feature. If they are fixes, please
help us out by motivating why they should go in during -rc instead of
in the next merge window. Thanks!


Also, see separate comment on the second patch (replied in that thread).


Regards,

-Olof
