From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 5 Feb 2013 16:38:07 +0100
Subject: [PATCH] ARM: Kirkwood: Add missing linux/i2c.h include
In-Reply-To: <20130205153411.GV14746@titan.lakedaemon.net>
References: <1360077025-8046-1-git-send-email-thierry.reding@avionic-design.de>
 <20130205153411.GV14746@titan.lakedaemon.net>
Message-ID: <20130205153807.GA22220@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 10:34:11AM -0500, Jason Cooper wrote:
> Thierry,
> 
> On Tue, Feb 05, 2013 at 04:10:25PM +0100, Thierry Reding wrote:
> > The nsa310 board uses I2C_BOARD_INFO and i2c_register_board_info(), both
> > of which are defined in the linux/i2c.h header file.
> > 
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> >  arch/arm/mach-kirkwood/board-nsa310.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> What is this based against?  We're in the process of removing this whole
> file for v3.9 (pinctrl, mv643xx_eth, and i2c)...

It's based on today's linux-next, so if you're going to drop that file
for 3.9 I guess you can ignore the patch.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130205/fc81f14a/attachment.sig>
