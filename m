From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 20 Nov 2014 11:17:18 +0100
Subject: voice calls on N900 working (off-line) was Re: N900 modem
 support in 3.18-rc1
In-Reply-To: <20141120101320.GA6356@amd>
References: <20141106180335.GA21513@earth.universe>
 <20141106225005.GA14002@amd> <201411070001.46481@pali>
 <545C6F14.8050303@gmail.com>
 <20141113162420.GB8512@xo-6d-61-c0.localdomain>
 <5465A977.4030605@gmail.com>
 <20141114172008.GB12250@earth.universe>
 <54665E02.8050108@gmail.com>
 <20141114215749.GA19023@earth.universe> <20141120101320.GA6356@amd>
Message-ID: <20141120101718.GA8128@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Ok, so realtime audio does not work due to some pulseaudio problems,
> but I was able to record a (silent) call and then replay it with 
> 
> pacat --rate 4000 ../../../pulseaudio2.raw
> 
> on my PC. I have yet to do some testing on the microphone side.

Did someone get pulseaudio to work on n900?

It somehow works for me, but not enough to actually produce sound.

root at n900:/my# pacat /my/pulseaudio2.raw 
Connection failure: Connection refused
pa_context_connect() failed: Connection refused
root at n900:/my# pacmd
Welcome to PulseAudio! Use "help" for usage information.
>>> list-modules
22 module(s) loaded.
    index: 0
    name: <module-device-restore>
    argument: <>
    used: -1
    load once: yes
...

mpg123 actually works ok after adjusting the mixers.

Any ideas?

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
