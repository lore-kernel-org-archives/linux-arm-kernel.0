From: broonie@debian.org (Mark Brown)
Date: Mon, 10 Nov 2014 12:13:35 +0000
Subject: ASoC: omap: enable sound support on n900 on devicetree-based boot
In-Reply-To: <20141109194151.GB7852@amd>
References: <20141109120222.GA3815@amd> <20141109123753.GO2722@sirena.org.uk>
 <20141109194151.GB7852@amd>
Message-ID: <20141110121335.GO3815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 09, 2014 at 08:41:51PM +0100, Pavel Machek wrote:
> With device tree, it is possible (and encouraged) to build N900
> kernels without CONFIG_MACH_NOKIA_RX51. Update config file to enable
> the driver build in this case.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141110/2630b708/attachment-0001.sig>
