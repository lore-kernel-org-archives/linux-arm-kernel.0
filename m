From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 30 May 2014 11:41:01 -0500 (CDT)
Subject: [GIT PULL] qcom driver changes for v3.16-2
Message-ID: <alpine.DEB.2.00.1405301138220.5291@galak-ubuntu.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5d144e36b7c51612922fa05d37ff3a869261cc82:

   soc: qcom: Add GSBI driver (2014-05-23 11:38:04 -0500)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-drivers-for-3.16-2

for you to fetch changes up to 31964ffebbb958c6cf289c7c12edd7530d6221b9:

   tty: serial: msm: Remove direct access to GSBI (2014-05-29 11:06:20 -0500)

----------------------------------------------------------------
Qualcomm ARM Based driver Updates for v3.16-2

* Updated MSM uart driver to not access GSBI control registers

----------------------------------------------------------------
Andy Gross (1):
       tty: serial: msm: Remove direct access to GSBI

  drivers/tty/serial/msm_serial.c | 48 ++---------------------------------------
  drivers/tty/serial/msm_serial.h |  5 -----
  2 files changed, 2 insertions(+), 51 deletions(-)

--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
