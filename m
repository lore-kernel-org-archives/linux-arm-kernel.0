From: broonie@kernel.org (Mark Brown)
Date: Thu, 3 Oct 2013 17:00:44 +0100
Subject: [PATCH 2/2] ASoC: fsl: Fix sound on mx31moboard
In-Reply-To: <1380630971-11431-3-git-send-email-philippe.retornaz@epfl.ch>
References: <1380630971-11431-1-git-send-email-philippe.retornaz@epfl.ch>
 <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
 <1380630971-11431-3-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <20131003160044.GW27287@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 02:36:11PM +0200, Philippe R?tornaz wrote:
> Commit 42810d (ASoC: imx-mc13783: Add audmux settings for mx27pdk) broke
> the sound on mx31moboard. Restore back the audmux setting on such boards.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131003/2a70d9da/attachment.sig>
