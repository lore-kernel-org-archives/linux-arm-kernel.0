From: broonie@kernel.org (Mark Brown)
Date: Mon, 12 Feb 2018 12:48:58 +0000
Subject: [PATCH v2 0/9] add UniPhier audio system support
In-Reply-To: <20180119092536.22501-1-suzuki.katsuhiro@socionext.com>
References: <20180119092536.22501-1-suzuki.katsuhiro@socionext.com>
Message-ID: <20180212124858.GC12976@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 19, 2018 at 06:25:27PM +0900, Katsuhiro Suzuki wrote:
> This series adds support for Socionext audio system for
> UniPhier LD11/LD20 SoCs. This driver supports I2S output
> for Line-In, Line-Out and S/PDIF output.

These look fine so I'll apply them however a patch series from
Morimoto-san (CCed) moving things to use components rather than
CODEC/platform/whatever driver types that was sent about the same time
has just gone in - the driver will require the same conversions.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180212/6836cc6d/attachment.sig>
