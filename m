From: tiwai@suse.de (Takashi Iwai)
Date: Mon, 22 May 2017 09:07:28 +0200
Subject: [PATCH 0/7] ALSA: Fix/improve PCM ack callback
In-Reply-To: <s5hmva5ie1r.wl-tiwai@suse.de>
References: <20170521190258.1178-1-tiwai@suse.de>
 <7685a366-5b2f-0a96-a686-c49b79975c56@sakamocchi.jp>
 <s5htw4dihpv.wl-tiwai@suse.de>
 <6cb4bbc8-2d5f-45d0-0635-37f1737972c3@sakamocchi.jp>
 <s5hmva5ie1r.wl-tiwai@suse.de>
Message-ID: <s5hh90did3j.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 May 2017 08:46:56 +0200,
Takashi Iwai wrote:
> 
> On Mon, 22 May 2017 08:31:13 +0200,
> Takashi Sakamoto wrote:
> > 
> > On May 22 2017 14:27, Takashi Iwai wrote:
> > > These functions will be modified again by other upcoming patchsets, so
> > > I'd like not to touch so much for minor optimization at this stage.
> > 
> > If you address to your latest patchset[1], it might not be applied
> > promptly because I have some comments (not posted yet, in this
> > night). It's not good to avoid better bahaviour in a reason of
> > patchset dependency, at least you seems to be too hasty.
> 
> Come on, your suggestion is an optimization change that can be applied
> anytime later easily.  If it were a mandatory fix, we should apply or
> fold it immediately, but that's not the case.  The only necessary
> thing is not to forget it.

That implies: just submit your proposed change as an incremental patch
on top of mine.  Then I'll queue it.


thanks,

Takashi
