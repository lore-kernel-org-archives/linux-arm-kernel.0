From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Nov 2014 18:08:28 +0000
Subject: [PATCH 2/2 v4] SPI: spi-pxa2xx: SPI support for Intel Quark X1000
In-Reply-To: <1416998110-4856-3-git-send-email-alvin.chen@intel.com>
References: <1416998110-4856-1-git-send-email-alvin.chen@intel.com>
 <1416998110-4856-3-git-send-email-alvin.chen@intel.com>
Message-ID: <20141126180828.GN7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 02:35:10AM -0800, Weike Chen wrote:
> There are two SPI controllers exported by PCI subsystem for Intel Quark X1000.
> The SPI memory mapped I/O registers supported by Quark are different from
> the current implementation, and Quark only supports the registers of 'SSCR0',
> 'SSCR1', 'SSSR', 'SSDR', and 'DDS_RATE'. This patch is to enable the SPI for
> Intel Quark X1000.

Applied, thanks.  Please use subject lines matching the style for the
subsystem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141126/9758f46d/attachment.sig>
