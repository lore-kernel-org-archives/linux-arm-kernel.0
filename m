From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Feb 2014 16:04:32 +0100
Subject: [alsa-devel] [PATCH 0/7] Audio support for Armada 370 DB
In-Reply-To: <20140210145729.GP1757@sirena.org.uk>
References: <1391102051-5319-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140210152141.1391fb67@skate>
 <20140210145729.GP1757@sirena.org.uk>
Message-ID: <20140210160432.27281741@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Mon, 10 Feb 2014 14:57:29 +0000, Mark Brown wrote:

> > Any comments on the patch series? I'd like these to be included in
> > 3.15, and so far I've only received one simple comment from Jason
> > Cooper regarding the defconfig changes, but no other comments.
> 
> Don't send contentless pings, they're more noise in the inbox.  In this
> case the fact that you didn't use subject lines matching the subsystem
> means that they tend to get pushed down my list (or more exactly don't
> come up when I search for patches for the subsystems I maintain).  If
> your subject lines stand out in git shortlog output for the area you're
> working on that's generally an issue, for example with ASoC you're
> looking for an "ASoC: ".

Sure, sorry. The patches that are of interest to you are prefixed by
"sound: codec" (for the patch touching sound/soc/codecs) and "sound:
soc" (for the patches touching sound/soc/kirkwood).

If you want, I can resend with subject lines containing 'ASoC:',
however maybe it's better if some other comments are made before, to
avoid additional noise.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
