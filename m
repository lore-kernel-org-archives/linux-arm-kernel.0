From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 10 Mar 2013 17:53:25 +0100
Subject: [PATCH 0/2] ARM: imx: kconfig changes for cpufreq-cpu0
Message-ID: <1362934407-29030-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the generic cpufreq-cpu0 cpufreq driver can be used by imx27
and imx5 with DT. At the moment there are some missing kconfig
selects. This patch adds them and removes imx-cpufreq if
imx27 or imx5 are compiled with cpufreq-cpu0 and DT support.

Regards,

Markus
