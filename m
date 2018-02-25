From: marcel@holtmann.org (Marcel Holtmann)
Date: Sun, 25 Feb 2018 21:17:27 +0100
Subject: [PATCH 1/4] Bluetooth: hci_bcm: Make shutdown and device wake
 GPIO optional
In-Reply-To: <1519567855-26105-2-git-send-email-stefan.wahren@i2se.com>
References: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
 <1519567855-26105-2-git-send-email-stefan.wahren@i2se.com>
Message-ID: <F4CD11EC-CEC2-4294-9895-0204269086FA@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

> According to the devicetree binding the shutdown and device wake
> GPIOs are optional. Since commit 3e81a4ca51a1 ("Bluetooth: hci_bcm:
> Mandate presence of shutdown and device wake GPIO") this driver
> won't probe anymore on Raspberry Pi 3 and Zero W (no device wake GPIO
> connected). So fix this regression by reverting this commit partially.
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Fixes: 3e81a4ca51a1 ("Bluetooth: hci_bcm: Mandate presence of shutdown and device wake GPIO")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
> drivers/bluetooth/hci_bcm.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel
