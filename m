From: andy.gross@linaro.org (Andy Gross)
Date: Thu,  7 Jul 2016 15:03:54 -0500
Subject: [GIT PULL] Qualcomm Driver Updates for v4.8 Part 2
Message-ID: <1467921834-13636-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2cd83c75d4d2cb9832ccb4989443195c2379493e:

  Merge tag 'qcom-drivers-for-4.8' into HEAD (2016-07-05 16:29:02 -0500)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git
tags/qcom-drivers-for-4.8-2

for you to fetch changes up to 6c8e99d874c96200ce985d19b407d49ed3306226:

  firmware: qcom: scm: Change initcall to subsys (2016-07-05 16:29:25 -0500)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v4.8 Part 2

* Fix probe order issue in SCM
* Add missing qcom_scm_is_available() API

----------------------------------------------------------------
Andy Gross (2):
      firmware: qcom_scm: Add missing is_available API
      firmware: qcom: scm: Change initcall to subsys

 drivers/firmware/qcom_scm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)
