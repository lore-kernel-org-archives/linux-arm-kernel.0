From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 16 Dec 2009 15:03:41 -0800
Subject: GPIO support for HTC Dream
In-Reply-To: <20091216225342.GH21102@elf.ucw.cz>
References: <4B1EB57D.6070408@bluewatersys.com>
	<20091208214658.GC4164@elf.ucw.cz> <4B1ECEEE.3000209@bluewatersys.com>
	<4B203575.6050407@bluewatersys.com> <20091210172458.GJ19454@elf.ucw.cz>
	<4B2150B7.3040207@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901FB0F92@mi8nycmail19.Mi8.com>
	<20091211221015.GB24456@elf.ucw.cz>
	<d6200be20912111440k427c5013j2b17191bcbae2d52@mail.gmail.com>
	<BD79186B4FD85F4B8E60E381CAEE190901FB10EB@mi8nycmail19.Mi8.com>
	<20091216225342.GH21102@elf.ucw.cz>
Message-ID: <1261004621.10141.82.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-12-16 at 23:53 +0100, Pavel Machek wrote:

> > Where is the msm tree located?  mach-msm in mainline doesn't appea to
> > have _any_ gpio support.  
> 
> Right.
> 
> > Is Pavel's implementation generic enough to
> > work with any msm based board?
> 
> I think so but I'm not sure; thats what I wanted google to
> clarify. Lets keep it dream-specific for now...

I don't think so, since it was something added by HTC.. I'm pretty sure
the generic msm gpio's are accessed differently.

Daniel
