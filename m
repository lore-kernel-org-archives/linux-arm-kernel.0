From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 4 Jul 2012 13:39:45 -0300
Subject: [PATCH] clk: mxs: imx28: decrease the frequency of ref_io1 for
 SSP2 and SSP3
In-Reply-To: <201207041823.27336.marex@denx.de>
References: <1341398994-28028-1-git-send-email-lauri.hintsala@bluegiga.com>
 <20120704133554.GB2595@S2101-09.ap.freescale.net>
 <201207041823.27336.marex@denx.de>
Message-ID: <CAOMZO5AK-SN6bv8PeGLFzRz-kObAL67wONyhoLuXeWDwMoJaeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 4, 2012 at 1:23 PM, Marek Vasut <marex@denx.de> wrote:

> What problem is that? I've been running the SPI driver against two types of SPI
> flashes on SSP2 without trouble ...

I guess Shawn is referring to this:
http://www.spinics.net/lists/arm-kernel/msg180725.html
