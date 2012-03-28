From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Mar 2012 15:36:50 +0100
Subject: [alsa-devel] [PATCH] ASoC: sgtl5000: fix power on/off of MIC bias
In-Reply-To: <20120328141812.GB3254@S2101-09.ap.freescale.net>
References: <1332919833-9641-1-git-send-email-shawn.guo@linaro.org>
 <7FE21149F4667147B645348EC605788514EDFF@039-SN2MPN1-011.039d.mgd.msft.net>
 <20120328141812.GB3254@S2101-09.ap.freescale.net>
Message-ID: <20120328143649.GU3232@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 10:18:14PM +0800, Shawn Guo wrote:
> On Wed, Mar 28, 2012 at 09:52:15AM +0000, Dong Aisheng-B29396 wrote:

> > IIRC for line-in record, it may also need VAG_POWER up.
> > Then only enable VAG_POWER for mic_bias_event may not be sufficient.
> > Will verify it latter when I'm free.

> This patch only fixes MIC.  I think you can submit another patch after
> you confirm LINE-IN has the same issue.

I think this is a sensible approach, two patches fixing two issues seems
reasonable (and I'd not expect line input to need the mic bias itself).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120328/2c19f2ec/attachment.sig>
