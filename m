From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 19 Sep 2015 00:08:59 +0200
Subject: [PATCH 2/2] ARM: at91: at91sam9n12ek/dts: fix the led labels name
In-Reply-To: <55FC15B9.9070407@atmel.com>
References: <27620a5315a0fd314e21eac4afbfe87f1350b099.1441897573.git.nicolas.ferre@atmel.com>
 <fca26d7ecb73e9691da4ee85e7e5bd8462638752.1441897573.git.nicolas.ferre@atmel.com>
 <20150910152415.GN3237@piout.net> <55FC15B9.9070407@atmel.com>
Message-ID: <20150918220859.GJ4287@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 18/09/2015 at 15:46:33 +0200, Nicolas Ferre wrote :
> > The only concern being that this renaming will break userspace software
> > assuming the LEDs are wrongly named. Is there anything that has been
> > released by atmel that uses the wrong names (and my guess is yess and
> > that is why there are named as such) and do you care about it?
> 
> My guess is that the label was wrongly named from the beginning and no
> board revision had the "d6" nor "d7" names.
> It makes sense to rename them for the evaluation kit...
> 

Yeah, I'm fine with the change. I was simply warning that it may break
some demos Atmel distributed before (but I didn't ever seen or used
those anyway so I may be wrong).

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
