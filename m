From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 13 Nov 2014 17:24:20 +0100
Subject: N900 modem support in 3.18-rc1
In-Reply-To: <545C6F14.8050303@gmail.com>
References: <20141104205117.GA17606@amd>
 <20141106180335.GA21513@earth.universe>
 <20141106225005.GA14002@amd> <201411070001.46481@pali>
 <545C6F14.8050303@gmail.com>
Message-ID: <20141113162420.GB8512@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2014-11-07 09:04:52, Ivaylo Dimitrov wrote:
> On  7.11.2014 01:01, Pali Roh?r wrote:
> >
> >For voice calls you need:
> >* kernel driver cmt-speech (or it has some new name)
> >* cmt-speech userspace library (communication with kernel)
> >* pulseaudio modules which are using that library
> >
> >Freemangordon (Ivaylo Dimitrov, CCed) should know more about it,
> >specially about pulseaudio modules...
> 
> I have a patch for cmt-speech on top of nokia-modem driver living
> somewhere on my HDD, but I guess it is better Sebastian to make such
> a patch (Sebastian, no?).

Sebastian is quiet, can we have the patch? :-).

> About the pulseaudio stuff - we're still in process of REing it, so
> far there are 2 out of 3 closed Nokia modules ready
> (https://gitorious.org/pulseaudio-nokia), but the last one, which is
> the one used for voice calls is still not ready and will take it a
> while :).

Ok, is there a way I could help? Pretty much everything else works with
opensource drivers...

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
