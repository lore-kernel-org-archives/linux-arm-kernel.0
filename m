From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 3 Mar 2012 16:37:34 +0000
Subject: [PATCH 4/4] ARM i.MX 3ds debugboard: register a dummy regulator
 for the smsc911x device
In-Reply-To: <1330774804-7310-5-git-send-email-s.hauer@pengutronix.de>
References: <1330774804-7310-1-git-send-email-s.hauer@pengutronix.de>
 <1330774804-7310-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120303163733.GC3071@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 03, 2012 at 12:40:04PM +0100, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/plat-mxc/3ds_debugboard.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

applied, though with at least this board you clearly do have a sensible
regulator setup already and are just adding in a few extra regulators to
fill out things which for some reason aren't supplied by the PMIC.  It's
quite surprising that things like what look like the I/O reference
voltage are supplied elsewhere.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120303/215a625f/attachment-0001.sig>
