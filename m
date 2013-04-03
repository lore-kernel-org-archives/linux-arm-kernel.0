From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Apr 2013 00:28:26 -0600
Subject: [PATCH] bcm2835: Add Broadcom BCM2835 RNG to the device tree
In-Reply-To: <1364451124-5039-1-git-send-email-lkundrak@v3.sk>
References: <1364135511-26970-1-git-send-email-lkundrak@v3.sk>
 <1364451124-5039-1-git-send-email-lkundrak@v3.sk>
Message-ID: <515BCC0A.4020608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2013 12:12 AM, Lubomir Rintel wrote:
> This adds a device tree binding for random number generator present on Broadcom
> BCM2835 SoC, used in Raspberry Pi and Roku 2 devices.

Applied to bcm2835's for-3.10/dt tree, with some slight fixups to the
patch subject and description word-wrapping.
