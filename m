From: metan@ucw.cz (Cyril Hrubis)
Date: Mon, 6 Jun 2011 13:21:32 +0200
Subject: 3.0-rc1: alsactl restore fails on spitz
In-Reply-To: <20110602031455.GC1565@ucw.cz>
References: <20110602031455.GC1565@ucw.cz>
Message-ID: <20110606112132.GA16715@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi! 
> Something changed in ALSA land, if you use sound you may want to check.

I've seen the errors on alsactl restore too. However sound seems to work for
me. Probably ALSA changed some ids of the knobs for alsamixer and the saved
state could not be properly restored.

-- 
metan
