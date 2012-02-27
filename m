From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 27 Feb 2012 13:54:25 +0000
Subject: [PATCHv2] regulator: twl6030: add support for vdd1, vdd2 and
 vdd3 regulators
In-Reply-To: <1330096902-20933-1-git-send-email-t-kristo@ti.com>
References: <1330096902-20933-1-git-send-email-t-kristo@ti.com>
Message-ID: <20120227135425.GE3191@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 05:21:42PM +0200, Tero Kristo wrote:
> vdd1 and vdd2 are now common regulators for twl4030 and twl6030. Also
> added vdd3 as a new regulator for twl6030. twl6030 vdd1...vdd3 smps
> regulator voltages can only be controlled through the smartreflex
> voltage channel, thus the support for the voltage_get and set is
> minimal and requires external controller.

Please coordinate with Rajendra and Peter to produce a unified set of
updates for this driver.  There's too many people sending overlapping
patches here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120227/faf30ef5/attachment.sig>
