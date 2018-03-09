From: broonie@kernel.org (Mark Brown)
Date: Fri, 9 Mar 2018 11:14:19 +0000
Subject: [BUG] Kernel crash on Allwinner H3 due to sound core changes
In-Reply-To: <87h8pq166i.wl%kuninori.morimoto.gx@renesas.com>
References: <2424862.oPtAVTfrB9@jernej-laptop>
 <20180302124050.GF6255@sirena.org.uk>
 <26212674.B0xcQEiVyd@jernej-laptop>
 <1832733.mujlD9skaR@jernej-laptop>
 <87efkvtldx.wl%kuninori.morimoto.gx@renesas.com>
 <20180308111348.GB6019@sirena.org.uk>
 <87h8pq166i.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20180309111419.GA5252@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2018 at 11:49:18PM +0000, Kuninori Morimoto wrote:

> previous my patch used new flag (= .alloced_component),
> but I think it is not good idea.
> And I noticed that snd_soc_add_component() is
> also calling kfree(component) (= has same bug).

> So how about below one ?
> I want to post it instead of previous.

That should work also.

> # I will go to ELC next week, thus posting patch will be
> # 2weeks later

I'll be there as well.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180309/3f008113/attachment.sig>
