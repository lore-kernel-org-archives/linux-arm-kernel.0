From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 22 Sep 2010 11:14:05 +0200
Subject: [PATCH 2/4] mmc: sdhci-pltfm: move .h-file into apropriate subdir
In-Reply-To: <20100922012011.GE27885@trinity.fluff.org>
References: <1285072210-10207-1-git-send-email-w.sang@pengutronix.de>
	<1285072210-10207-3-git-send-email-w.sang@pengutronix.de>
	<20100922012011.GE27885@trinity.fluff.org>
Message-ID: <20100922091405.GC2693@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 22, 2010 at 02:20:11AM +0100, Ben Dooks wrote:
> On Tue, Sep 21, 2010 at 02:30:08PM +0200, Wolfram Sang wrote:
> > Make use of the mmc-directory.
> > 
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > ---
> >  drivers/mmc/host/sdhci-cns3xxx.c |    2 +-
> >  drivers/mmc/host/sdhci-pltfm.c   |    2 +-
> >  drivers/mmc/host/sdhci-pltfm.h   |    2 +-
> >  include/linux/mmc/sdhci-pltfm.h  |   35 +++++++++++++++++++++++++++++++++++
> >  include/linux/sdhci-pltfm.h      |   35 -----------------------------------
> 
> hmm, you lost rename detection... best enable it to make these diffs clearer.

Do you mean just for the diffstat or for the whole patch? I am
reluctant to do the latter because you can't apply patches with plain
'patch' anymore. Or are git-patches considered standard meanwhile?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100922/2d2d5aa1/attachment.sig>
