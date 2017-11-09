From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 9 Nov 2017 23:54:40 +0000
Subject: [alsa-devel] [PATCH 0/2] ASoC: add mclk-fs support to audio
 graph	card
In-Reply-To: <1510236478-2351-1-git-send-email-olivier.moysan@st.com>
References: <1510236478-2351-1-git-send-email-olivier.moysan@st.com>
Message-ID: <87wp2zkocm.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

> The aim of these patches is to port mclk-fs property to audio graph card, 
> as originally implemented in simple card.
> 
> Olivier Moysan (2):
>   ASoC: add mclk-fs to audio graph card binding
>   ASoC: add mclk-fs support to audio graph card
> 
>  .../devicetree/bindings/sound/audio-graph-card.txt |  1 +
>  sound/soc/generic/audio-graph-card.c               | 47 ++++++++++++++++++----
>  2 files changed, 40 insertions(+), 8 deletions(-)

For all patches
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
