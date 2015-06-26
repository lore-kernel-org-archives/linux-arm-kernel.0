From: yvo@apm.com (Y Vo)
Date: Fri, 26 Jun 2015 15:01:46 +0700
Subject: [PATCH v1] arm64: dts: Add poweroff button device node for APM X-Gene
 platform
Message-ID: <1435305707-22786-1-git-send-email-yvo@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds poweroff button device node to support poweroff feature
on APM X-Gene Mustang platform.

V1 change:
	- Remove unused property.

Y Vo (1):
  arm64: dts: Add poweroff button device node for APM X-Gene platform

 arch/arm64/boot/dts/apm/apm-mustang.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)
