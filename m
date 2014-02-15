From: simon.guinot@sequanux.org (Simon Guinot)
Date: Sat, 15 Feb 2014 21:15:21 +0100
Subject: [PATCH 0/2] Add alarm suport for the Microchip RTC devices MCP794xx
Message-ID: <1392495323-22875-1-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds alarm support for the Microchip RTC devices
MCP794xx. A such compatible RTC (MCP7940NT) is embedded on the Seagate
boards n090x01 (based on the Armada-370 SoC).

Regards,

Simon

Simon Guinot (2):
  rtc: rtc-ds1307: fix sysfs wakealarm attribute creation
  rtc: rtc-ds1307: add alarm support for mcp7941x chips

 drivers/rtc/rtc-ds1307.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 183 insertions(+), 2 deletions(-)

-- 
1.8.5.3
