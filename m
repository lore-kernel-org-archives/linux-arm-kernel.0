From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 04 May 2010 10:33:18 +0200
Subject: [PATCH] Add support for Aquita board (Samsung S5PC110 based)
In-Reply-To: <1269515719-18519-1-git-send-email-m.szyprowski@samsung.com>
References: <1269515719-18519-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <011501caeb64$74eb38f0$5ec1aad0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, March 25, 2010 12:15 PM Marek Szyprowski wrote:

> This patch series add basic support for Samsung Aquila board. The board
> is based on Samsung S5PC110 SoC. For the basic support of this board, the
> S5PV210/S5PC110 platform core needs to be updated. This patch series
> contains patches that add support for gpiolib, software reset and
> framebuffer helpers. Please expect further extensions to the s5pv210
> platform core soon.

Is there any progress or comments on merging these patches? What about
other s5pv210/s5pc110 patches that were posted here?

Some of them are really important bugfixes:
ARM: S5P6440: Bug fix on PWM Timer
ARM: S5P6442: Bug fix on PWM Timer
ARM: S5PV210: Bug fix on PWM Timer
ARM: Samsung: fix broken timer irq base

The other add really important features to the platform:
ARM: S5P: Add System Timer
ARM: Samsung: S5PC100 platform cleanup
Add S5PV210/S5PC110 platform helpers
ARM: Samsung: Add platform support code for OneNAND controller

How can I help merging new features and drivers to the Samsung SoC platform?

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
