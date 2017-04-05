From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 5 Apr 2017 23:31:07 +0000
Subject: [PATCH] cs-2000-cp: keep Reserved bit on each register
In-Reply-To: <20170405190423.GL18246@codeaurora.org>
References: <87y3vfxw3q.wl%kuninori.morimoto.gx@renesas.com>
 <20170405190423.GL18246@codeaurora.org>
Message-ID: <87wpay4er9.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Stephen

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > Thus CS2000 datasheet is indicating below, this patch
> > follows it.
> > 
> > WARNING: All "Reserved" registers must maintain their default
> >          state to ensure proper functional operation.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Is this v2? I see two of these from different days.

Oops ?
I'm sorry,  I thought I didn't post this.
These are same patch.

Best regards
---
Kuninori Morimoto
