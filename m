From: B47053@freescale.com (Xiubo Li-B47053)
Date: Mon, 21 Oct 2013 07:24:56 +0000
Subject: [PATCHv1 8/8] Documentation: Add device tree bindings for
 Freescale VF610 sound.
In-Reply-To: <20131018173126.GU2443@sirena.org.uk>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-9-git-send-email-Li.Xiubo@freescale.com>
 <20131018173126.GU2443@sirena.org.uk>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82866807@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +  -- Power supplies:
> > +     * Mic Bias
> > +
> > +  -- SGTL5000 pins:
> > +     * MIC_IN
> > +     * LINE_IN
> > +     * HP_OUT
> > +     * LINE_OUT
> 
> Things that are part of the CODEC should be part of the CODEC binding and
> this binding should reference that - this way the information doesn't
> have to be replicated by all boards using the CODEC and if new devices
> are supported by the CODEC driver then only that needs updating hopefully.
>

Yes, the "-- SGTL5000 pins:" should be in the CODEC binding.
But, actually the CODEC binding hasn't any reference about this.

So I added it here, but not very sure.
