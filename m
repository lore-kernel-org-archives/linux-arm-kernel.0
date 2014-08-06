From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 6 Aug 2014 20:29:04 +0200
Subject: [RFC 0/8] DPCM with simple-card support for Kirkwood
In-Reply-To: <20140806175313.GC19574@lunn.ch>
References: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
 <20140806103356.4e7c088a@armhf> <20140806143026.GA19574@lunn.ch>
 <20140806194304.3a1867a8@armhf> <20140806175313.GC19574@lunn.ch>
Message-ID: <20140806202904.3016cb0b@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Aug 2014 19:53:13 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> Does it not work correctly because of a property of the hardware, or
> because of bugs in the DPCM implementation? From what you pointed out
> in the mailing lists, it seems like bugs.

As I explained, DPCM shunts the routing. The constraints are not
handled, so, the formats and rates are always those of the front-end.
And this is normal, because DPCM is done for devices with a firmware
which adapts the back-ends to the chosen front-end format and rate.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
