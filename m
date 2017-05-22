From: o-takashi@sakamocchi.jp (Takashi Sakamoto)
Date: Mon, 22 May 2017 15:31:13 +0900
Subject: [PATCH 0/7] ALSA: Fix/improve PCM ack callback
In-Reply-To: <s5htw4dihpv.wl-tiwai@suse.de>
References: <20170521190258.1178-1-tiwai@suse.de>
 <7685a366-5b2f-0a96-a686-c49b79975c56@sakamocchi.jp>
 <s5htw4dihpv.wl-tiwai@suse.de>
Message-ID: <6cb4bbc8-2d5f-45d0-0635-37f1737972c3@sakamocchi.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On May 22 2017 14:27, Takashi Iwai wrote:
> These functions will be modified again by other upcoming patchsets, so
> I'd like not to touch so much for minor optimization at this stage.

If you address to your latest patchset[1], it might not be applied 
promptly because I have some comments (not posted yet, in this night). 
It's not good to avoid better bahaviour in a reason of patchset 
dependency, at least you seems to be too hasty.


[1] [alsa-devel] [PATCH 00/16] ALSA: Convert to new copy_silence PCM ops

Regards

Takashi Sakamoto
