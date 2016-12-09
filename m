From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Fri, 9 Dec 2016 00:55:18 +0000
Subject: [PATCH 3/3] ASoC: simple-card-utils: enable
 clocks/clock-names/clock-ranges
In-Reply-To: <20161209002635.GD5423@codeaurora.org>
References: <874m2jvtmw.wl%kuninori.morimoto.gx@renesas.com>
 <87zikbuezr.wl%kuninori.morimoto.gx@renesas.com>
 <20161208220901.GN5423@codeaurora.org>
 <874m2eymu3.wl%kuninori.morimoto.gx@renesas.com>
 <20161209002635.GD5423@codeaurora.org>
Message-ID: <87y3zpylbc.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Stephen

> > > I don't see any reason why we need this patch though. The binding
> > > works as is, so supporting different styles doesn't seem like a
> > > good idea to me. Let's just keep what we have? Even if a sub-node
> > > like cpu or codec gets more than one element in the clocks list
> > > property, we can make that work by passing a clock-name then
> > > based on some sort of other knowledge.
> > 
> > OK, thanks. Let's skip this patch.
> > But I believe this idea/method itself is not wrong (?)
> > 
> Right it's not wrong, just seems confusing to have two methods.

Thanks.
Very clear for me :)
