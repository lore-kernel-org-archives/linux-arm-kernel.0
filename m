From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 02 Jul 2014 09:47:18 +0200
Subject: ASoC: samsung: MACH_SMDK6450
Message-ID: <1404287238.12021.7.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin,

Your commit 0aeaa68cf509 ("ASoC: samsung: no more support for S5P6440
and S5P6450 SoCs") landed in next-20140702. It removed references to
MACH_SMDK6440 and MACH_SMDK6450 from sound/soc/samsung/.

It seems to have missed one reference to MACH_SMDK6450 in
sound/soc/samsung/Kconfig (an optional dependency of
SND_SOC_SMDK_WM8580_PCM). Is the oneliner to remove that optional
dependency queued somewhere?


Paul Bolle
