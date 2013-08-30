From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Fri, 30 Aug 2013 00:20:47 -0700 (PDT)
Subject: [alsa-devel] [PATCH RFC 00/13] Adding SPDIF support
 to	kirkwood-i2s
In-Reply-To: <87wqnzhek5.wl%kuninori.morimoto.gx@renesas.com>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com> <20130805115947.GA9858@sirena.org.uk>
 <51FFA348.2010503@gmail.com> <51FFB267.3030107@metafoo.de>
 <87wqnzhek5.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <87li3jr6et.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

> > Kuninori Morimoto started working on a xlate callback for CODECs and DAIs
> > some time ago[1]. If nobody else is going to pick this up I'm probably going
> > to continue his work on this.
> 
> Thank you for your offer about above.
> I'm sorry for my late work for xlate callback.
> but, unfortunately, I busy now, so, I can't work for it now.
> I'm very happy if someone/you can work for it.

My understanding for this ASoC DT support milestone is that

 1) merge codec/component
 2) add .of_xlate_dai_name on it
 3) add DT support

But, do you think 1) is possible ?
Becouse, now, too many functions are based on/using "codec"
struct snd_soc_codec / struct snd_soc_codec_driver.
In reality, merging these is super difficult IMO.

But adding .of_xlate_dai_name on each codec/component
is not difficult, and, I can do it immediately.

what is your opinion ?

Best regards
---
Kuninori Morimoto
