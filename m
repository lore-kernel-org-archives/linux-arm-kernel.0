From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 8 Oct 2013 19:40:55 +0200
Subject: [PATCH v2 0/2] ARM: Dove: Add audio to the DT
Message-ID: <20131008194055.00fc93c2@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds audio DT to the Dove boards and activates the
Cubox audio device.

Full audio in the Cubox will work when the DT extension of the generic
simple audio card will be complete.

v2:
- dove.dtsi: change the audio controller compatible string to
	"marvell,dove-audio" (Thomas Petazzoni)
- dove-cubox: add the external clock (Sebastian Hesselbarth)

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
