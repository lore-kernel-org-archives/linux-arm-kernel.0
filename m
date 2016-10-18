From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 18 Oct 2016 19:57:13 +0200
Subject: [PATCH 0/5] drm/sun4i: Handle TV overscan
In-Reply-To: <20161018100349.qm2f554oiwyjwrsi@lukather>
References: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
 <20161018092422.GJ1041@n2100.armlinux.org.uk>
 <20161018100349.qm2f554oiwyjwrsi@lukather>
Message-ID: <20161018195713.6d5e847927f792f99a3cb252@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Oct 2016 12:03:49 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> The fourth one being the major one. Every time I raised the issue on
> IRC, the answer basically was "we don't care about analog", so I'm a
> bit pessimistic about whether dealing with this in the core would be
> accepted, hence why I chose to deal with this at the driver level.

The same problem exists with HDMI and old TVs (mine is an ASUS 22T1E):
these TVs overscan as soon as AVI frames are in the stream.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
