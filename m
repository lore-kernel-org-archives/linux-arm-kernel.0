From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Nov 2015 12:03:43 +0000
Subject: [RFC] ASoC: Add mediatek HDMI codec driver
In-Reply-To: <1446638053-12143-1-git-send-email-p.zabel@pengutronix.de>
References: <1446638053-12143-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20151104120343.GZ20228@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 12:54:13PM +0100, Philipp Zabel wrote:

> This driver is based on the work of DW HDMI codec driver.
> It controls mediatek HDMI Tx's audio module, and handles
> HDMI jack detection by sharing IRQ with HDMI Tx.

How does this relate to all the other HDMI related work that's going on,
especially around handling of the EDID data?  I'm not seeing anything in
here that uses the constraints code that Russell added for example.  As
I keep saying I really want to see some collaboration and consensus here
with the goal of sharing code and achieving a consistent userspace
interface rather than a lot of individual independently implemented
drivers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151104/9c4958b1/attachment-0001.sig>
