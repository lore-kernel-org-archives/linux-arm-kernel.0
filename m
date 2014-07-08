From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 8 Jul 2014 11:39:45 +0200
Subject: [alsa-devel] [PATCH v2] ASoC: tda998x: add a codec to the HDMI
 transmitter
In-Reply-To: <53BBB746.1000201@arm.com>
References: <20140704091733.10258cfe@armhf>
	<53BBB746.1000201@arm.com>
Message-ID: <20140708113945.29b6be7f@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 08 Jul 2014 10:17:58 +0100
Andrew Jackson <Andrew.Jackson@arm.com> wrote:

> > +       static const u32 hdmi_rates[] = {
> > +               32000, 44100, 48000, 88200, 9600, 176400, 192000
> > +       };
> > +  
> 
> Shouldn't this be 96000, not 9600?  Assuming that the table is ordered in terms of increasing frequencies.

You are right. Thank you.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
