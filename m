From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 Nov 2013 08:49:29 +0100
Subject: [PATCH v4 0/4] Add support for the Allwinner A31 Reset Controllers
In-Reply-To: <1384798284.4348.33.camel@pizza.hi.pengutronix.de>
References: <1384539547-29463-1-git-send-email-maxime.ripard@free-electrons.com>
 <1384798284.4348.33.camel@pizza.hi.pengutronix.de>
Message-ID: <20131119074929.GE5325@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Mon, Nov 18, 2013 at 07:11:24PM +0100, Philipp Zabel wrote:
> Hi Maxime,
> 
> Am Freitag, den 15.11.2013, 19:19 +0100 schrieb Maxime Ripard:
> > Hi everyone,
> > 
> > This patchset adds support for the reset controllers found in the Allwinner A31
> > SoCs. Since these controllers are pretty simple, basically just a few MMIO
> > registers, with a single bit controlling the reset state of the other devices
> > it asserts in reset, the driver is quite simple as well.
> > 
> > However, one of the IPs asserted in reset by these controllers are the timers,
> > the only thing standing out is that it requires to be registered before the
> > timers are initialized.
> > 
> > Thanks,
> > Maxime
> 
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks.

Do you want to merge this through your tree?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131119/aed5fad8/attachment-0001.sig>
