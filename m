From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Jan 2018 18:13:52 +0000
Subject: PM regression in next
In-Reply-To: <20180115180626.GL4821@atomide.com>
References: <20180112215010.GG4821@atomide.com>
 <20180112221126.GK21458@sirena.org.uk>
 <20180112224959.GH4821@atomide.com>
 <20180112225947.GL21458@sirena.org.uk>
 <87wp0jzyig.wl%kuninori.morimoto.gx@renesas.com>
 <20180115165050.GJ4821@atomide.com>
 <20180115171917.GB12018@sirena.org.uk>
 <20180115175220.GK4821@atomide.com>
 <20180115175626.GC12018@sirena.org.uk>
 <20180115180626.GL4821@atomide.com>
Message-ID: <20180115181352.GD12018@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 10:06:26AM -0800, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [180115 17:56]:

> > Sorry, I didn't actually post it - just suggested adding the
> > snd_soc_codec_set_regmap() call.

> Oh I see. Yeah that seems like a good long term solution after
> the regressions are fixed.

I would like to see us do that sooner rather than later assuming it
addresses the issue, it's quicker and simpler.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180115/114cd280/attachment.sig>
