From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:48 +0200
Subject: [PATCH 35/40] ARM i.MX: remove now unused old clock support
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-36-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/clock-imx1.c      |  636 -----------
 arch/arm/mach-imx/clock-imx21.c     | 1239 --------------------
 arch/arm/mach-imx/clock-imx25.c     |  346 ------
 arch/arm/mach-imx/clock-imx27.c     |  785 -------------
 arch/arm/mach-imx/clock-imx31.c     |  630 -----------
 arch/arm/mach-imx/clock-imx35.c     |  536 ---------
 arch/arm/mach-imx/clock-imx6q.c     | 2111 -----------------------------------
 arch/arm/mach-imx/clock-mx51-mx53.c | 1675 ---------------------------
 8 files changed, 7958 deletions(-)
 delete mode 100644 arch/arm/mach-imx/clock-imx1.c
 delete mode 100644 arch/arm/mach-imx/clock-imx21.c
 delete mode 100644 arch/arm/mach-imx/clock-imx25.c
 delete mode 100644 arch/arm/mach-imx/clock-imx27.c
 delete mode 100644 arch/arm/mach-imx/clock-imx31.c
 delete mode 100644 arch/arm/mach-imx/clock-imx35.c
 delete mode 100644 arch/arm/mach-imx/clock-imx6q.c
 delete mode 100644 arch/arm/mach-imx/clock-mx51-mx53.c

diff --git a/arch/arm/mach-imx/clock-imx1.c b/arch/arm/mach-imx/clock-imx1.c
deleted file mode 100644
index 4aabeb2..0000000
diff --git a/arch/arm/mach-imx/clock-imx21.c b/arch/arm/mach-imx/clock-imx21.c
deleted file mode 100644
index ee15d8c..0000000
diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
deleted file mode 100644
index b0fec74c..0000000
diff --git a/arch/arm/mach-imx/clock-imx27.c b/arch/arm/mach-imx/clock-imx27.c
deleted file mode 100644
index 98e04f5..0000000
diff --git a/arch/arm/mach-imx/clock-imx31.c b/arch/arm/mach-imx/clock-imx31.c
deleted file mode 100644
index 3a943cd..0000000
diff --git a/arch/arm/mach-imx/clock-imx35.c b/arch/arm/mach-imx/clock-imx35.c
deleted file mode 100644
index e56c1a8..0000000
diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
deleted file mode 100644
index 111c328..0000000
diff --git a/arch/arm/mach-imx/clock-mx51-mx53.c b/arch/arm/mach-imx/clock-mx51-mx53.c
deleted file mode 100644
index 0847050..0000000
-- 
1.7.9.5
