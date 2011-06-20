From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 20 Jun 2011 23:13:15 +0200
Subject: GIT pull request - lpc32xx core updates
In-Reply-To: <083DF309106F364B939360100EC290F811EDEE8AB8@eu1rdcrdc1wx030.exi.nxp.com>
References: <1301592646-26356-1-git-send-email-w.sang@pengutronix.de>
	<083DF309106F364B939360100EC290F811ED78EE79@eu1rdcrdc1wx030.exi.nxp.com>
	<20110402110304.GD21760@pengutronix.de>
	<083DF309106F364B939360100EC290F811EDEE8AB8@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20110620211315.GC16148@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Wed, Apr 06, 2011 at 12:33:43AM +0200, Kevin Wells wrote:
> 
> Hi Russell,
> 
> Can you please pull these reviewed updates for the LPC32xx?
> 
>   git://git.lpclinux.com/linux-2.6-lpc for_rmk_32xx_04_05
> 
> Wolfram Sang (3):
>       arm: lpc32xx: add tsc-device
>       arm: lpc32xx: add rtc-device
>       arm: lpc32xx: clock: use bool logic instead of binary
> 
>  arch/arm/mach-lpc32xx/clock.c  |    4 +-
>  arch/arm/mach-lpc32xx/common.c |   42 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-lpc32xx/common.h |    2 +
>  3 files changed, 46 insertions(+), 2 deletions(-)

Could you try again for the next merge-window? :)

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110620/ab48e23f/attachment.sig>
