From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 4 Mar 2012 13:32:42 +0000
Subject: [PATCH 00/20] ASoC: add imx-sgtl5000 machine driver working with
 fsl_ssi
In-Reply-To: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120304133242.GC3083@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 03, 2012 at 11:19:41PM +0800, Shawn Guo wrote:
> It's the full series adding imx-sgtl5000 machine driver which works
> with fsl_ssi driver on DT based imx platforms.
>  - Patches 1 ~ 5: Convert audmux driver to a platform driver and move
>    it into ASoC folder.
>  - Patches 6 ~ 12: Merge ASoC imx and fsl folders.

This also contains a bunch of random cleanups and refactorings which
*really* should have been at the start of the series so they could be
applied without dependencies on the other stuff...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120304/dd7feaf3/attachment.sig>
