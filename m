From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 22 Jan 2014 11:46:47 +0100
Subject: [alsa-devel] [PATCH RFC v2 REPOST 3/8] ASoC: davinci-evm: HDMI
 audio support for TDA998x trough McASP I2S bus
In-Reply-To: <20140122111953.238349a5@armhf>
References: <cover.1387535299.git.jsarha@ti.com>
 <d3c3f645d39338df0ee9686cb030255ce36a249d.1387535302.git.jsarha@ti.com>
 <20131231132555.GA31886@sirena.org.uk> <52D67099.1040904@ti.com>
 <20140115165100.3bfab96f@armhf> <52DF8D60.9020505@ti.com>
 <20140122111953.238349a5@armhf>
Message-ID: <20140122114647.20f75d0d@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Jan 2014 11:19:53 +0100
Jean-Francois Moine <moinejf@free.fr> wrote:

> As both I2S and S/PDIF may be used for HDMI output in the Cubox,
> I wrote a tda998x CODEC which gets the audio ports from the DT and
> dynamically sets these ports and the audio type (i2s / spdif) on audio
> streaming start. I have not submitted yet this codec and the associated
> changes in tda998x, because I am waiting for a first patch series on the
> tda998x to be applied
> (http://lists.freedesktop.org/archives/dri-devel/2014-January/051552.html).

Sorry, the last patch request is

http://lists.freedesktop.org/archives/dri-devel/2014-January/052201.html

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
