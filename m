From: yong.shen@freescale.com (yong.shen at freescale.com)
Date: Wed, 12 Jan 2011 17:14:45 +0800
Subject: ARM i.MX53 enable SMD&LOCO board bootup
Message-ID: <1294823687-20520-1-git-send-email-yong.shen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

change log:
remove gpio_set_value(SMD_FEC_PHY_RST, 0) according to discussion.
