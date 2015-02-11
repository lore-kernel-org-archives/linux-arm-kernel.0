From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 11 Feb 2015 21:56:54 +0100
Subject: Voice calls working on N900 (*) (was Re: N900 modem support in
 3.18-rc1)
In-Reply-To: <20150211183228.GB29636@amd>
References: <20141104205117.GA17606@amd>
 <20141106180335.GA21513@earth.universe>
 <20141106225005.GA14002@amd> <201411070001.46481@pali>
 <545C6F14.8050303@gmail.com>
 <20141113162420.GB8512@xo-6d-61-c0.localdomain>
 <5465A977.4030605@gmail.com>
 <20141114172008.GB12250@earth.universe>
 <54665E02.8050108@gmail.com> <20150211183228.GB29636@amd>
Message-ID: <20150211205654.GA1936@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> (*) for low values of working.
> 
> Ok, so I got voice on n900 to work on 3.19-n900 tree.. Quality of incoming
> voice is reasonable, quality of outgoing voice not so, I was told.
> 
> So, you need patched kernel (pali's n900 tree) ofono etc, plus I'm
> using ofone python script to control the modem, plus you need
> libcmtspeechdata. I have this version:

I put libcmtspeechdata at gitorious:

git at gitorious.org:libcmtspeechdata/libcmtspeechdata.git

ofone control scripts are at:

git at gitorious.org:tui/tui.git

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
