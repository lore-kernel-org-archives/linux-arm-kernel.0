From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jan 2014 11:56:51 +0100
Subject: [PATCH v2 0/28] drm/i2c: tda998x: add DT support and other
 improvements
Message-ID: <20140109115651.482e2db1@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set contains various extensions to the tda998x driver:

- simplify the i2c read/write
- code cleanup and fix some small errors
- use HDMI constants
- don't read write-only registers
- add DT support
- use irq for connection status and EDID read
- get a better status of the HDMI connector
- use the tda998x video format when cea mode
- add tda998x codec interface

- v2
	- decompose patches with different topics
	- fix some bad i2c register values
	- add audio codec interface

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
