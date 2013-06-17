From: timur@tabi.org (Timur Tabi)
Date: Sun, 16 Jun 2013 23:05:53 -0500
Subject: [PATCH v8 00/11] ASoC: fsl-ssi: ac97-slave support
In-Reply-To: <1371389117-19729-1-git-send-email-mpa@pengutronix.de>
References: <1371389117-19729-1-git-send-email-mpa@pengutronix.de>
Message-ID: <51BE8B21.8050605@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Markus Pargmann wrote:
> Hi,
>
> This series adds DT support for phycore-ac97. Beside ac97 support, the series
> adds imx-pcm-fiq and generic DMA bindings to fsl-ssi.
>
> In version 8 I fixed the build issues by seperating the DT capable ac97 phycore
> driver from the old driver.

FYI, I get some warnings applying this patchset:

Applying: ASoC: Add phycore-ac97-dt driver
/home/b04825/git/linux.alsa2/.git/rebase-apply/patch:375: new blank line 
at EOF.
+
warning: 1 line adds whitespace errors.
Applying: ASoC: fsl: Kconfig: Use fsl-ssi for phycore-ac97
Applying: ASoC: fsl: Move fsl-ssi binding doc to sound/
Applying: ASoC: fsl: Update fsl-ssi binding doc
/home/b04825/git/linux.alsa2/.git/rebase-apply/patch:33: space before tab 
in indent.
   		    Only necessary for some boards with incompatible
warning: 1 line adds whitespace errors.

-- 
Timur Tabi
