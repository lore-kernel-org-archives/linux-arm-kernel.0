From: jiujin.hong@mid-fun.com (tommy)
Date: Thu, 22 Oct 2009 18:45:22 +0800
Subject: about ARM11 WM9715 no sound when resume
In-Reply-To: <20091022103927.GB3776@sirena.org.uk>
References: <1256180289.11383.0.camel@tommy-desktop>
	<20091022103927.GB3776@sirena.org.uk>
Message-ID: <1256208322.23498.1.camel@tommy-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,brown!
It can playback mp3 from start to end,also can't indicate its clock is
ok ?

On ?, 2009-10-22 at 11:39 +0100, Mark Brown wrote:
> On Thu, Oct 22, 2009 at 10:58:09AM +0800, tommy wrote:
> > Platform:Linux 2.6.24.2
> 
> This is a very old kernel, I would strongly recommend upgrading to
> something more current, it will make it much easier for you to seek
> upstream support.
> 
> >               When MCU resume from suspend,no sound but can also
> > playback from start to end!
> >                It has sound only by modifing sound setting applicantion
> > program!
> 
> The wm971x ASoC drivers have suspend and resume support which is fairly
> widely used on a number of platforms.  However, there may be problems
> with the CPU drivers.  As a first step I would suggest checking to make
> sure that the master clock to the CODEC is restarted after resume and
> that the AC97 link is succesfully restarted.
> 
