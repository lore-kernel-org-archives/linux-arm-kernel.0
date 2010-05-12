From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 12 May 2010 15:27:52 +0200
Subject: Linux Bluetooth HFP through usp pcm design questions
In-Reply-To: <1273024014.9369.1.camel@ben-desktop>
References: <1273024014.9369.1.camel@ben-desktop>
Message-ID: <AANLkTim-rJYweW0PxtEEpDt54VjI_8Y1H5YBum8uerC-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/5 Bin Shi <Bin.Shi@csr.com>
>
> Hi all,
>
>
> I am working on vendor ARM1136 platform. Nowdays, I want to integrate
> CSR BC06 chip to my board with HFP profile, bluetooth chip connect its
> pcm interface with platform's usp interface.
>
> As I know, HFP profile should has at least two deamons, one for host and
> one for target(BC06). In low level, driver for usp pcm should be
> available, which is compatible with BC06 frame format. Now, audio path
> is OK for playback and capture with ALSA.
>
> My questions are:
> 1) How could I control stream path: eg headphone voice->BC06->usp
> interface->platform speaker?
> 2) Should it be strictly sync for controlling this application?
> 3) Data format between usp interface and headphone interface(bypass
> bluetooth) should be pcm stream?
>
>
> Any suggestion would be welcomed! Thanks.
>

HFP works very well on the desktop Linux distro now. I suggest you
to give Ubuntu a run and figure out how that works. You have a big
question here.

Both ALSA and pulseaudio have bluetooth plugins.

PS: html format emails are generally not welcome, change it to plain
text and it's far more readable for other people.
