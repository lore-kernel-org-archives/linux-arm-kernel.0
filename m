From: sleep_walker@suse.cz (=?utf-8?q?Tom=C3=A1=C5=A1_=27Sleep=5FWalker=27?=
	=?utf-8?q?_=C4=8Cech?=)
Date: Mon, 31 Aug 2009 19:33:47 +0200
Subject: update Treo680, generalise it and add Centro support - round 2
Message-ID: <200908311933.47363.sleep_walker@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

it seems that introduction e-mail didn't reach, so:

this is second round of patch set updating Treo680, generalising it and adding support for Palm Centro. Since this is based on Eric's PXA kernel tree, there is not applied commit 'Treo680: fix freed GPIO in treo680_irda_shutdown()' yet. For Russel's tree this can be just ommited.

Changes since last time:
 - patch set generated properly (with respect of file renames)
 - fixed name of keyboard backlight LED (now treo680:white:keybbl, centro:white:keybbl)

Thanks for your time and comments.

Best regards,

Tomas Cech
