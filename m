From: timur@tabi.org (Timur Tabi)
Date: Sun, 07 Apr 2013 19:20:20 -0500
Subject: [PATCH v2 10/11] ASoC: fsl: Move fsl-ssi binding doc to sound/
In-Reply-To: <1365362721-3731-11-git-send-email-mpa@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-11-git-send-email-mpa@pengutronix.de>
Message-ID: <51620D44.3030105@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Markus Pargmann wrote:
> fsl-ssi was located in powerpc/fsl/ssi.txt. This is no powerpc specific
> device, so it should be moved to sound/ as it connects to differen audio
> codecs.

The only problem with this is that the driver supports two bindings, the 
original binding and a newer one.  The original binding is used only on 
PowerPC.

I'm not sure that's relevant, though.

-- 
Timur Tabi
