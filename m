From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Mon,  5 Jan 2015 11:04:12 +0100
Subject: [RESEND PATCH 0/2] pinctrl-st: various fixes 
Message-ID: <1420452254-30625-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resend this series, it seems that the one i send in 
December has been lost despite it was visible on lkml

Two fixes for pinctrl-st pinctrl driver

Francesco VIRLINZI (1):
  pinctrl: st: avoid multiple mutex lock

Patrice Chotard (1):
  pinctrl: st: Add irq_disable hook to st_gpio_irqchip

 drivers/pinctrl/pinctrl-st.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
1.9.1
