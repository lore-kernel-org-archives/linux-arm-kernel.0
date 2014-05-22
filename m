From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 22 May 2014 16:18:14 +0100
Subject: Add SDHCI support for STMicroelectronics SoCs
Message-ID: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds a SDHCI platform driver for ST SoCs, along with
the additional device tree bindings and configuration to enable
the controller to work properly.

Initially it supports the stih416 and stih415 SoCs, and has
been tested on a stih416-b2020 board.

regards,

Peter.
