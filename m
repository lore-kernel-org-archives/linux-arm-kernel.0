From: maz@misterjones.org (Marc Zyngier)
Date: Sat, 14 Nov 2009 16:20:41 +0100
Subject: [PATCH 0/3] Support for the Arcom Zeus SBC
Message-ID: <20091114162041.5cbbb58e@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Arcom Zeus is a pxa270 board with a PC104 bus, vaguely similar to
the Arcom Viper. The following patches adds support for most of the
on-board devices (though sound and CAN are still missing).

Patches are against 2.6.32-rc7. Please note that this depends on the
following patch, currently queued in Eric's fix branch:
http://git.kernel.org/?p=linux/kernel/git/ycmiao/pxa-linux-2.6.git;a=commit;h=b2b36316626f0d6b92c3675a2aa2726efc71d146

This work started from Arcom's 2.6.16, but all bugs are of course mine.

	M.
-- 
I'm the slime oozin' out from your TV set...
