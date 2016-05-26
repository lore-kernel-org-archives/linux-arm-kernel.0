From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 26 May 2016 14:24:21 -0700
Subject: [PATCH v2 0/4] pinctrl: meson-gxbb: add a bunch more pins
Message-ID: <1464297865-8965-1-git-send-email-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for several more devices, both in the EE domain and in the
AO domain.  Also, add the pins to the corresponding DTS files.

Tested on odroid-c2 and Amlogic P200 boards, and verified with working
ethernet.

Changes since v1:
- dropped the rename of uart_ao -> uart_ao_a (will be done as follow-up)
- rebased on linus/master
- dropped DT from series (will be merged through arm-soc)

Kevin

Kevin Hilman (4):
  pinctrl: amlogic: gxbb: add UART_AO_B, I2C
  pinctrl: amlogic: gxbb: add EMMC and SD pins
  pinctrl: amlogic: gxbb: add more UART pins
  pinctrl: amlogic: gxbb: add ethernet pins

 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 163 ++++++++++++++++++++++++++++-
 1 file changed, 162 insertions(+), 1 deletion(-)

-- 
2.7.4
