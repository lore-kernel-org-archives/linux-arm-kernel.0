From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 1 Apr 2013 12:45:19 +0100
Subject: [PATCH 03/13] ASoC: mxs-saif: remove mach header inclusion
In-Reply-To: <1364547350-30498-4-git-send-email-shawn.guo@linaro.org>
References: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
 <1364547350-30498-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130401114519.GB18636@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 29, 2013 at 04:55:39PM +0800, Shawn Guo wrote:
> The header <mach/hardware.h> is not needed at all, and <mach/mxs.h> is
> needed only for macros MXS_SET_ADDR and MXS_CLR_ADDR.  Define the macros
> and remove the mach header inclusions.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130401/d2f41cdb/attachment-0001.sig>
