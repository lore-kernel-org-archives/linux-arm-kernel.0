From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 4 Feb 2014 20:02:39 +0100
Subject: [PATCH v3 3/5] ASoC: tda998x: add DT documentation of the
 tda998x CODEC
In-Reply-To: <20140204181213.GO22609@sirena.org.uk>
References: <cover.1391274627.git.moinejf@free.fr>
 <8e4231b7a55802f58a14dd07ac5cd8b0babb1dce.1391274628.git.moinejf@free.fr>
 <20140204181213.GO22609@sirena.org.uk>
Message-ID: <20140204200239.1baf309b@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Feb 2014 18:12:13 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Sat, Feb 01, 2014 at 05:48:49PM +0100, Jean-Francois Moine wrote:
> 
> > +	- compatible: must be "nxp,tda998x-codec".
> 
> It's not clear to me why there's a separate compatible here - as far as
> I can see this can only appear as part of one of these devices and
> there's no addressing or other information that'd account for chip
> variation so I'd not expect to need to bind this independently of the
> parent.

If there is no 'compatible', the CODEC module is not loaded, and, when
the module is in the core, no CODEC device can be created from the DT.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
