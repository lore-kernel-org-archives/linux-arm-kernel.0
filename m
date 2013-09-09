From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 9 Sep 2013 20:15:15 +0000 (UTC)
Subject: [PATCH v2] ARM: omap2: throw the die id into the entropy pool
In-Reply-To: <alpine.DEB.2.02.1309091908270.28435@utopia.booyaka.com>
References: <1378366158-31183-1-git-send-email-linus.walleij@linaro.org>
 <alpine.DEB.2.02.1309091908270.28435@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.02.1309092012000.28435@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


By the way, if anyone wants to expand on Linus' patch for OMAP, there are 
several other register fields that could be mixed in, which, based on 
their names, might vary on a per-chip basis.  For example, on OMAP4, the 
CONTROL_STD_FUSE_OPP* and CONTROL_DPLL_NWELL_TRIM* registers.



- Paul
