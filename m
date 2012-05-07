From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 May 2012 10:10:02 +0100
Subject: [PATCH 1/3] regulator: add pre-regulator support for 88pm860x
In-Reply-To: <20120506022954.GB29576@lizard>
References: <1332825916-2183-1-git-send-email-jtzhou@marvell.com>
 <20120506022954.GB29576@lizard>
Message-ID: <20120507091001.GB4415@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 05, 2012 at 07:29:54PM -0700, Anton Vorontsov wrote:

> OK to let me take this via battery tree?

No, there's now substantial conflicts with the regulator driver's
ongoing development.  For example, the driver has been converted to use
the core regmap support for enable and disable.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120507/b4147d61/attachment.sig>
