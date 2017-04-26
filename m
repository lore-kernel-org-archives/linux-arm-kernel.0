From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Apr 2017 15:45:21 +0100
Subject: [PATCH v3 08/12] regulator: axp20x-regulator: add support for
 AXP803
In-Reply-To: <20170417115747.7300-9-icenowy@aosc.io>
References: <20170417115747.7300-1-icenowy@aosc.io>
 <20170417115747.7300-9-icenowy@aosc.io>
Message-ID: <20170426144521.iesgvi5m63rpckpy@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 17, 2017 at 07:57:43PM +0800, Icenowy Zheng wrote:
> AXP803 PMIC also have a series of regulators (DCDCs and LDOs)
> controllable via I2C/RSB bus.
> 
> Add support for them.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170426/7e9f32cf/attachment.sig>
