From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 23 Mar 2014 11:19:03 +0100
Subject: [PATCH v2] drm/i2c: tda998x: Change the compatible strings
In-Reply-To: <532C40B0.3000805@gmail.com>
References: <20140321115541.01cbbb06@armhf>
	<532C40B0.3000805@gmail.com>
Message-ID: <20140323111903.51c73c82@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Mar 2014 14:37:52 +0100
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> >   Required properties;
> > -  - compatible: must be "nxp,tda998x"
> > +  - compatible: may be "nxp,tda9989", "nxp,tda19988" or "nxp,tda19989"  
> 
> There is a "DT is ABI" policy and although there is no mainline Linux
> user of current compatible, the correct way would be to deprecate
> "nxp,tda998x" and introduce new compatibles.

Pratically, what is this way?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
