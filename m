From: jkosina@suse.cz (Jiri Kosina)
Date: Tue, 20 Jul 2010 17:27:34 +0200 (CEST)
Subject: [PATCH 31/33] Removing dead MACH_U300_BS26
In-Reply-To: <AANLkTikyk4fu72kWFfxQyEV_GHTc5flLYytF9cnHDBE_@mail.gmail.com>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<2a81bf5506ce15ac839ca4fa58dc8af4112ff531.1277911346.git.siccegge@cs.fau.de>
	<AANLkTikyk4fu72kWFfxQyEV_GHTc5flLYytF9cnHDBE_@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1007201727160.4741@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Jul 2010, Linus Walleij wrote:

> > MACH_U300_BS26 doesn't exist in Kconfig, therefore removing all
> > references for it from the source code.
> >
> > Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> 
> OK then,
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>

As this doesn't seem to be present in linux-next as of today, I have 
applied it to trivial queue. Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
