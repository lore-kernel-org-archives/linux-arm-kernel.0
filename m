From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 22 Sep 2014 11:02:44 -0700
Subject: [PATCH v3 0/2] bus: brcmstb_gisb: misc fixes
Message-ID: <1411408966-15390-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

This patch set contains two small fixes for the Broadcom GISB bus
arbiter code. First patch makes sure we do register a fault code for
ARM platforms, second patch is a fix when the code is used on a PM
capable system.

Florian Fainelli (2):
  bus: brcmstb_gisb: register the fault code hook
  bus: brcmstb_gisb: save and restore GISB timeout

 drivers/bus/brcmstb_gisb.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

-- 
1.9.1
