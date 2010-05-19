From: metan@ucw.cz (Cyril Hrubis)
Date: Wed, 19 May 2010 17:46:18 +0200
Subject: usb gadget on zaurus and kexec
Message-ID: <20100519154618.GA26381@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
After some testing I found out that no usb gadget (g_ether, g_mass_storage, ...)
is working after zaurus boots with kexec. So it seems like some missing
initalization (it's working after doing reboot again) anybody has any clue,
patch or ideas how to debug this?

-- 
Cyril Hrubis
