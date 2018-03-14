From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Wed, 14 Mar 2018 15:43:23 +0800
Subject: [PATCH 8/8] ARM: dts: berlin2cd: add Valve Steam Link board
In-Reply-To: <alpine.LNX.2.20.13.1803141013040.21514@monopod.intra.ispras.ru>
References: <20180311160008.22928-1-amonakov@ispras.ru>
 <20180311160008.22928-9-amonakov@ispras.ru>
 <20180314142326.572642c3@xhacker.debian>
 <alpine.LNX.2.20.13.1803141013040.21514@monopod.intra.ispras.ru>
Message-ID: <20180314154323.184cf435@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Mar 2018 10:22:11 +0300 Alexander Monakov wrote:

> On Wed, 14 Mar 2018, Jisheng Zhang wrote:
> 
> > > +/*
> > > + * Copyright 2018 Alexander Monakov <amonakov@gmail.com>
> > > + *
> > > + * SPDX-License-Identifier: (GPL-2.0 OR MIT)  
> > 
> > Mind to license it under GPL2 or X11?  
> 
> MIT is the same as X11 but without the references to the X Consortium that
> do not make sense in the kernel context: please see [1] and [2]. The MIT
> license is present under LICENSES/preferred in the kernel tree, but not the
> X11 license.

Understood.

> 
> The berlin2cd.dtsi file first says "the X11 license", but then the actual
> license text appearing in the file is the MIT license.

Yes, I'll send patches to add SPDX tags to all berlin SoC dtsi and s/X11/MIT.

Thanks for pointing this out.

> 
> [1] https://spdx.org/licenses/MIT.html
> [2] https://spdx.org/licenses/X11.html
> 
> > Other source usually tag as:
> > // SPDX-License-Identifier: (GPL-2.0 OR X11)
> > 
> > And the tag is put into the first line, could we keep the style?  
> 
> Right. With the clarification regarding X11/MIT above, I'll change to
> 
> // SPDX-License-Identifier: GPL-2.0 OR MIT
> // Copyright 2018 Alexander Monakov <amonakov@gmail.com>
> 
> Is that okay?

Yes, it's OK.
