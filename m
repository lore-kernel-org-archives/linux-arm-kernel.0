From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Mon, 31 May 2010 11:15:39 +0100
Subject: [alsa-devel] [patch 0/6] kirkwood openrd client audio support - v4
In-Reply-To: <20100527125737.524554667@mandriva.com>
References: <20100527125737.524554667@mandriva.com>
Message-ID: <1275300939.3174.6.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-05-27 at 14:57 +0200, apatard at mandriva.com wrote:
> Hi,
> 
> This patchset is an other try to get merged openrd audio support mainline.
> The main change is going back to using kirkwood instead of orion, as the 
> only orion having i2s is not merged mainline (if I got it right).
> I've also fixed the lastests comments on the cs42l51 codec patch.
> 
> Arnaud
> 
> Changes :
> - changed back from orion to kirkwood
> - removed cs42l51 adc input register initialisation
> - moved the DAPM event macro to soc-dapm
> - fixed cs42l51_set_dai_fmt() master/slave check
> - removed cs42l51 startup message
> - use snd_soc_update_bits() in cs42l51_pdn_event()

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
