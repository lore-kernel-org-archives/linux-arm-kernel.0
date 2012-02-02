From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Feb 2012 13:26:18 +0000
Subject: [PATCH v2 6/9] ARM: mx31ads: add audmux device
In-Reply-To: <20120202131716.GF9773@S2101-09.ap.freescale.net>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-7-git-send-email-richard.zhao@linaro.org>
 <20120202120900.GC7428@opensource.wolfsonmicro.com>
 <20120202131716.GF9773@S2101-09.ap.freescale.net>
Message-ID: <20120202132618.GL7428@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 09:17:18PM +0800, Shawn Guo wrote:
> On Thu, Feb 02, 2012 at 12:09:01PM +0000, Mark Brown wrote:

> > Since the audmux is a part of the SoC silicon shouldn't the SoC just
> > register the device without individual boards having to do anything
> > (possibly conditional on ASoC being selected in Kconfig or something)?
> > It's going to be connected in exactly the same fashion on any system
> > using the SoC.

> Hmm, we are trying to save adding the device for those boards which do
> not route any audmux pins out at all.

That's why I'm saying perhaps make it conditional on having ASoC built
(or even on having the AUDMUX driver built).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120202/c5e5f132/attachment-0001.sig>
