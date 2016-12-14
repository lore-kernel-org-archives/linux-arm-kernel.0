From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 14 Dec 2016 23:37:07 +0100
Subject: [PATCH 00/39] ARM: dts: mvebu: Fix license text
Message-ID: <20161214223746.23066-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the license was switched to dual GPLv2/X11, the text that was used
was missing a few characters. Fix that now.

I'll let the maintainers decide whether this change requires an ack of
every contributors. It has been separated with that in mind if
necessary.

Cc: Andrew Andrianov <andrew@ncrmnt.org>
Cc: Arnaud Ebalard <arno@natisbad.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Benjamin Cama <benoar@dolka.fr>
Cc: Benoit Masson <yahoo@perenite.com>
Cc: Ben Peddell <klightspeed@killerwolves.net>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Florian Fainelli <florian@openwrt.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Ungerer <gerg@uclinux.org>
Cc: Grzegorz Jaszczyk <jaz@semihalf.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Lior Amsalem <alior@marvell.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Marcin Wojtas <mw@semihalf.com>
Cc: Mario Lange <mario_lange@gmx.net>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Nadav Haklai <nadavh@marvell.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Bolle <pebolle@tiscali.nl>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rafa? Mi?ecki <zajec5@gmail.com>
Cc: Roger Shimizu <rogershimizu@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Ryan Press <ryan@presslab.us>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Simon Baatz <gmbnomis@gmail.com>
Cc: Simon Guinot <simon.guinot@sequanux.org>
Cc: Stefan Roese <sr@denx.de>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Yehuda Yitschak <yehuday@marvell.com>

Alexandre Belloni (39):
  ARM: dts: armada-370-db: Correct license text
  ARM: dts: armada-370-dlink-dns327l: Correct license text
  ARM: dts: armada-370: Correct license text
  ARM: dts: armada-370-mirabox: Correct license text
  ARM: dts: armada-370-netgear-rn102: Correct license text
  ARM: dts: armada-370-netgear-rn104: Correct license text
  ARM: dts: armada-370-rd: Correct license text
  ARM: dts: armada-370-synology-ds213j: Correct license text
  ARM: dts: armada-370-xp: Correct license text
  ARM: dts: armada-375-db: Correct license text
  ARM: dts: armada-375: Correct license text
  ARM: dts: armada-38x: Correct license text
  ARM: dts: armada-388-clearfog: Correct license text
  ARM: dts: armada-388-db: Correct license text
  ARM: dts: armada-388-rd: Correct license text
  ARM: dts: armada-38x-solidrun-microsom: Correct license text
  ARM: dts: armada-390-db: Correct license text
  ARM: dts: armada-390: Correct license text
  ARM: dts: armada-395: Correct license text
  ARM: dts: armada-398-db: Correct license text
  ARM: dts: armada-398: Correct license text
  ARM: dts: armada-39x: Correct license text
  ARM: dts: armada-xp-axpwifiap: Correct license text
  ARM: dts: armada-xp-db: Correct license text
  ARM: dts: armada-xp: Correct license text
  ARM: dts: armada-xp-gp: Correct license text
  ARM: dts: armada-xp-lenovo-ix4-300d: Correct license text
  ARM: dts: armada-xp-matrix: Correct license text
  ARM: dts: armada-xp-mv78230: Correct license text
  ARM: dts: armada-xp-mv78260: Correct license text
  ARM: dts: armada-xp-mv78460: Correct license text
  ARM: dts: armada-xp-netgear-rn2120: Correct license text
  ARM: dts: armada-xp-openblocks-ax3-4: Correct license text
  ARM: dts: armada-xp-synology-ds414: Correct license text
  ARM: dts: dove-cm-a510: Correct license text
  ARM: dts: dove-sbc-a510: Correct license text
  ARM: dts: kirkwood-linkstation: Correct license text
  ARM: dts: orion5x-kuroboxpro: Correct license text
  ARM: dts: orion5x-lswsgl: Correct license text

 arch/arm/boot/dts/armada-370-db.dts                  | 10 +++++-----
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts       | 10 +++++-----
 arch/arm/boot/dts/armada-370-mirabox.dts             | 10 +++++-----
 arch/arm/boot/dts/armada-370-netgear-rn102.dts       | 10 +++++-----
 arch/arm/boot/dts/armada-370-netgear-rn104.dts       | 10 +++++-----
 arch/arm/boot/dts/armada-370-rd.dts                  | 10 +++++-----
 arch/arm/boot/dts/armada-370-synology-ds213j.dts     | 10 +++++-----
 arch/arm/boot/dts/armada-370-xp.dtsi                 | 10 +++++-----
 arch/arm/boot/dts/armada-370.dtsi                    | 10 +++++-----
 arch/arm/boot/dts/armada-375-db.dts                  | 10 +++++-----
 arch/arm/boot/dts/armada-375.dtsi                    | 10 +++++-----
 arch/arm/boot/dts/armada-380.dtsi                    | 10 +++++-----
 arch/arm/boot/dts/armada-385.dtsi                    | 10 +++++-----
 arch/arm/boot/dts/armada-388-clearfog.dts            | 10 +++++-----
 arch/arm/boot/dts/armada-388-db.dts                  | 10 +++++-----
 arch/arm/boot/dts/armada-388-rd.dts                  | 10 +++++-----
 arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi  | 10 +++++-----
 arch/arm/boot/dts/armada-38x.dtsi                    | 10 +++++-----
 arch/arm/boot/dts/armada-390-db.dts                  | 10 +++++-----
 arch/arm/boot/dts/armada-390.dtsi                    | 10 +++++-----
 arch/arm/boot/dts/armada-395.dtsi                    | 10 +++++-----
 arch/arm/boot/dts/armada-398-db.dts                  | 10 +++++-----
 arch/arm/boot/dts/armada-398.dtsi                    | 10 +++++-----
 arch/arm/boot/dts/armada-39x.dtsi                    | 10 +++++-----
 arch/arm/boot/dts/armada-xp-axpwifiap.dts            | 10 +++++-----
 arch/arm/boot/dts/armada-xp-db.dts                   | 10 +++++-----
 arch/arm/boot/dts/armada-xp-gp.dts                   | 10 +++++-----
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts      | 10 +++++-----
 arch/arm/boot/dts/armada-xp-matrix.dts               | 10 +++++-----
 arch/arm/boot/dts/armada-xp-mv78230.dtsi             | 10 +++++-----
 arch/arm/boot/dts/armada-xp-mv78260.dtsi             | 10 +++++-----
 arch/arm/boot/dts/armada-xp-mv78460.dtsi             | 10 +++++-----
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts       | 10 +++++-----
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts     | 10 +++++-----
 arch/arm/boot/dts/armada-xp-synology-ds414.dts       | 10 +++++-----
 arch/arm/boot/dts/armada-xp.dtsi                     | 10 +++++-----
 arch/arm/boot/dts/dove-cm-a510.dtsi                  | 10 +++++-----
 arch/arm/boot/dts/dove-sbc-a510.dts                  | 10 +++++-----
 arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi     | 10 +++++-----
 arch/arm/boot/dts/kirkwood-linkstation-duo-6281.dtsi | 10 +++++-----
 arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts     | 10 +++++-----
 arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts      | 10 +++++-----
 arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dts    | 10 +++++-----
 arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts     | 10 +++++-----
 arch/arm/boot/dts/kirkwood-linkstation-lswxl.dts     | 10 +++++-----
 arch/arm/boot/dts/kirkwood-linkstation.dtsi          | 10 +++++-----
 arch/arm/boot/dts/mvebu-linkstation-fan.dtsi         | 10 +++++-----
 arch/arm/boot/dts/mvebu-linkstation-gpio-simple.dtsi | 10 +++++-----
 arch/arm/boot/dts/orion5x-kuroboxpro.dts             | 10 +++++-----
 arch/arm/boot/dts/orion5x-linkstation-lsgl.dts       | 10 +++++-----
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts     | 10 +++++-----
 arch/arm/boot/dts/orion5x-linkstation.dtsi           | 10 +++++-----
 arch/arm/boot/dts/orion5x-lswsgl.dts                 | 10 +++++-----
 53 files changed, 265 insertions(+), 265 deletions(-)

-- 
2.10.2
