From: rickard.andersson@stericsson.com (Rickard ANDERSSON)
Date: Mon, 27 May 2013 13:40:55 +0200
Subject: [PATCH V2 0/3] mmc: mmci: Support ap_sleep in cpuidle for ux500
In-Reply-To: <1369302307-28540-1-git-send-email-ulf.hansson@stericsson.com>
References: <1369302307-28540-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <C832F8F5D375BD43BFA11E82E0FE9FE0115A936A54@EXDCVYMBSTM005.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Rickard Andersson <rickard.andersson@stericsson.com>

-----Original Message-----
From: Ulf HANSSON 
Sent: den 23 maj 2013 11:45
To: linux-arm-kernel at lists.infradead.org; Russell King
Cc: linux-mmc at vger.kernel.org; Chris Ball; Daniel Lezcano; Linus Walleij; Rickard ANDERSSON; Ulf Hansson
Subject: [PATCH V2 0/3] mmc: mmci: Support ap_sleep in cpuidle for ux500

From: Ulf Hansson <ulf.hansson@linaro.org>

To be able to enter ap_sleep state in cpuidle were the APE power domain regulator will be cut, a register save and restore mechanism needs to be implemented. This patchset adapts to these restrictions.

Ulf Hansson (3):
  mmc: mmci: Use optional sleep pinctrl state
  mmc: mmci: Adapt to register write restrictions
  mmc: mmci: Save and restore register context

 drivers/mmc/host/mmci.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/mmci.h |    1 +
 2 files changed, 76 insertions(+)

--
1.7.10
