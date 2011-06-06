From: tiwai@suse.de (Takashi Iwai)
Date: Mon, 06 Jun 2011 16:10:52 +0200
Subject: 3.0-rc1: alsactl restore fails on spitz
In-Reply-To: <20110602031455.GC1565@ucw.cz>
References: <20110602031455.GC1565@ucw.cz>
Message-ID: <s5hboyb6oer.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Thu, 2 Jun 2011 05:14:55 +0200,
Pavel Machek wrote:
> 
> Hi
> 
> Something changed in ALSA land, if you use sound you may want to check.

alsactl is known to grumble when the mixer element number id is
changed.  It just complains but does his job at best, continuing to
restore the mixer status by guessing from the element name.  So,
usually it should work as is.


Takashi
