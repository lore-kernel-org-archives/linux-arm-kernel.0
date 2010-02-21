From: linux@dominikbrodowski.net (Dominik Brodowski)
Date: Sun, 21 Feb 2010 10:21:57 +0100
Subject: [PATCH  0/3] MXC PCMCIA Support
In-Reply-To: <4B80109C.5080005@gmail.com>
References: <20100220153200.19692.70098.stgit@srv002.fuzzey.net>
	<20100220155150.GA3591@n2100.arm.linux.org.uk>
	<4B80109C.5080005@gmail.com>
Message-ID: <20100221092157.GC22104@comet.dominikbrodowski.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Sat, Feb 20, 2010 at 05:41:00PM +0100, Martin Fuzzey wrote:
> Russell King - ARM Linux wrote:
> > I do wonder whether, as you have windows, you should be using the soc
> > support - the soc support is based interfacing hardware which does not
> > have windows into the generic infrastructure which assumes the presence
> > of windows.
> >   
> Hi Russell,
> Yes I understand what you mean.
> 
> I asked on -pcmcia about the approach back in June 2009:
> http://marc.info/?l=linux-pcmcia&m=124805223926065&w=2
> but didn't get a reply :(
> 
> OTOH soc_common provides some other useful stuff like polling thread,
> common interrupt handler core, common debug etc.

What's your opinion in light of this?

Best,
	Dominik
