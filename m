From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 30 May 2010 16:44:47 -0400 (EDT)
Subject: [patch 0/6] kirkwood openrd client audio support - v4
In-Reply-To: <20100527125737.524554667@mandriva.com>
References: <20100527125737.524554667@mandriva.com>
Message-ID: <alpine.LFD.2.00.1005301638420.24526@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 May 2010, apatard at mandriva.com wrote:

> 
> Hi,
> 
> This patchset is an other try to get merged openrd audio support mainline.
> The main change is going back to using kirkwood instead of orion, as the 
> only orion having i2s is not merged mainline (if I got it right).

Right.

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

I acked the first patch which touches directly the directory I normally 
handle patches for.  Given the series is mostly about ASOC stuff, I 
think it is best if the whole series, including the first patch, is 
pushed through the ASOC tree (if Mark agrees with the rest that is of 
course).


Nicolas
