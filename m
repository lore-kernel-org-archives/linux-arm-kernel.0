From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 10 May 2010 05:05:21 +0100
Subject: [alsa-devel] about ALC203 linux driver
In-Reply-To: <AANLkTik0GudetGLF9hF56_VV_tNci8wX0S67gAWDIayq@mail.gmail.com>
References: <AANLkTikvaFWOlapz9_HlHc1GBlky_FX1-5ml-iFNGGQW@mail.gmail.com>
	<20100509144940.GA7457@sirena.org.uk>
	<AANLkTik0GudetGLF9hF56_VV_tNci8wX0S67gAWDIayq@mail.gmail.com>
Message-ID: <20100510040521.GF6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 09, 2010 at 11:34:28PM +0800, Wan ZongShun wrote:
> Dear Mark,
> 
> 
> 2010/5/9 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> > On Sun, May 09, 2010 at 10:40:07PM +0800, Wan ZongShun wrote:
> >
> >> At present, there is a ALC203 AC97 codec in my Winbond ARM board, and
> >> I am programming
> >> the audio driver based on ALSA, Who can tell me whether the current
> >> ALSA is supporting
> >> the ALC203 driver?how to enable it?
> >
> > You need a driver for the AC97 controller your system is using (for most
> > ARM systems this is part of the CPU). ?Since AC97 provides a standard
> > register interface for CODECs Linux does not require specific support
> > for individual AC97 CODECs in order to get core functionality working.
> >
> 
> There is AC97 support for my chip, and I have implemented the nuc900_ac97.c
> ,nuc900_pcm.c and machine board c file drivers.The three main
> structure definitions
> as following:

does you SoC require any other configurations in other blocks that
may aslo affect this, such as gpio configuratioon for the ac97 pins or
some sort of clock setup?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
