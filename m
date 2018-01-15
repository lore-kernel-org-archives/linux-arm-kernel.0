From: tony@atomide.com (Tony Lindgren)
Date: Mon, 15 Jan 2018 10:06:26 -0800
Subject: PM regression in next
In-Reply-To: <20180115175626.GC12018@sirena.org.uk>
References: <20180112211535.GH21458@sirena.org.uk>
 <20180112215010.GG4821@atomide.com>
 <20180112221126.GK21458@sirena.org.uk>
 <20180112224959.GH4821@atomide.com>
 <20180112225947.GL21458@sirena.org.uk>
 <87wp0jzyig.wl%kuninori.morimoto.gx@renesas.com>
 <20180115165050.GJ4821@atomide.com>
 <20180115171917.GB12018@sirena.org.uk>
 <20180115175220.GK4821@atomide.com>
 <20180115175626.GC12018@sirena.org.uk>
Message-ID: <20180115180626.GL4821@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown <broonie@kernel.org> [180115 17:56]:
> On Mon, Jan 15, 2018 at 09:52:20AM -0800, Tony Lindgren wrote:
> > * Mark Brown <broonie@kernel.org> [180115 17:19]:
> 
> > > Did anyone actually try testing the fix I posted yet?
> 
> > Hmm I don't seem to have anything in my inbox. What might
> > be the subject for it?
> 
> Sorry, I didn't actually post it - just suggested adding the
> snd_soc_codec_set_regmap() call.

Oh I see. Yeah that seems like a good long term solution after
the regressions are fixed.

Regards,

Tony
