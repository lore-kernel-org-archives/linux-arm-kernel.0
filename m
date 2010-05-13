From: Bin.Shi@csr.com (Bin Shi)
Date: Thu, 13 May 2010 09:58:19 +0800
Subject: Linux Bluetooth HFP through usp pcm design questions
In-Reply-To: <AANLkTim-rJYweW0PxtEEpDt54VjI_8Y1H5YBum8uerC-@mail.gmail.com>
References: <1273024014.9369.1.camel@ben-desktop>
	<AANLkTim-rJYweW0PxtEEpDt54VjI_8Y1H5YBum8uerC-@mail.gmail.com>
Message-ID: <1273715900.25892.12.camel@ben-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-05-12 at 15:27 +0200, Eric Miao wrote:
> 2010/5/5 Bin Shi <Bin.Shi@csr.com>
> >
> > Hi all,
> >
> >
> > I am working on vendor ARM1136 platform. Nowdays, I want to integrate
> > CSR BC06 chip to my board with HFP profile, bluetooth chip connect its
> > pcm interface with platform's usp interface.
> >
> > As I know, HFP profile should has at least two deamons, one for host and
> > one for target(BC06). In low level, driver for usp pcm should be
> > available, which is compatible with BC06 frame format. Now, audio path
> > is OK for playback and capture with ALSA.
> >
> > My questions are:
> > 1) How could I control stream path: eg headphone voice->BC06->usp
> > interface->platform speaker?
> > 2) Should it be strictly sync for controlling this application?
> > 3) Data format between usp interface and headphone interface(bypass
> > bluetooth) should be pcm stream?
> >
> >
> > Any suggestion would be welcomed! Thanks.
> >
> 
> HFP works very well on the desktop Linux distro now. I suggest you
> to give Ubuntu a run and figure out how that works. You have a big
> question here.
> 
> Both ALSA and pulseaudio have bluetooth plugins.

HFP for Linux project in http://nohands.sourceforge.net/, which is for
Bluetooth Hands-Free profile server. Has any one try that already? 

> 
> PS: html format emails are generally not welcome, change it to plain
> text and it's far more readable for other people.
> 

Thanks for your advise.:)

> 
>  To report this email as spam click https://www.mailcontrol.com/sr/wQw0zmjPoHdJTZGyOCrrhg== .


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
