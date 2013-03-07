From: davidb@codeaurora.org (David Brown)
Date: Wed,  6 Mar 2013 16:29:41 -0800
Subject: [PATCH 0/6] Qualcomm SSBI bus driver
Message-ID: <1362616187-21089-1-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This small series adds the Qualcomm SSBI bus driver.  The original
driver was developed as part of Android.  Kenneth Heitke updated this,
and sent it out a while back.  This series updates this driver to use
DeviceTree, and fixes a few things that have changed since it was
originally sent out.

In addition, the 6th patch, the RFC, is a small test driver that reads
the version register off of the pm8058 device typically connected to
an MSM8660 or MSM8960.  This is primarily useful to anyone wanting to
work on these pmic drivers.

Updates to the PMIC drivers themselves to use this driver to come.

David
