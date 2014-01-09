From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu,  9 Jan 2014 11:16:09 +0100
Subject: [PATCH 0/2] fsl-ssi fixups
In-Reply-To: <20140108172144.GP31886@sirena.org.uk>
References: <20140108172144.GP31886@sirena.org.uk>
Message-ID: <1389262571-12489-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks, here are the two fixups for the series. The binding documentation did
not contain a list of compatibles yet, so I added it.

Regards,

Markus


Markus Pargmann (2):
  ASoC: fsl-ssi doc: Add list of supported compatibles
  ASoC: fsl-ssi: Fix stats compile warning

 Documentation/devicetree/bindings/sound/fsl,ssi.txt | 7 ++++++-
 sound/soc/fsl/fsl_ssi.c                             | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
1.8.5.2
