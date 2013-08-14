From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 14 Aug 2013 12:27:15 +0200
Subject: [PATCH v5 0/1] ASoc: kirkwood: extend the kirkwood audio subsystem
 for DT usage
Message-ID: <20130814122715.45c2d9ad@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds DT support to the kirkwood/mvebu audio subsystem.

History
v5
	- change the DT name to "marvell,mvebu-audio"
v4
	- change the DT name to "mrvl,mvebu-audio"
	- remove previous patches 1..3 which have been applied by Russell King
v3
	- change the DT name from "kirkwood-i2s" to "mvebu-pcm-audio"
	- apply to linux-next
	- let NULL as the internal i2s clock for compatibility
	- change i2s external clock name to "extclk" instead of "external"
	- cancel previous patch 1/4. Russell's patch should be applied instead.
v2
	- fix compilation errors

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
