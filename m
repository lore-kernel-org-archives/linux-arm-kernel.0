From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 01 Apr 2013 20:38:44 -0600
Subject: [PATCH] bcm2835: Add Broadcom BCM2835 RNG to the device tree
In-Reply-To: <1364451124-5039-1-git-send-email-lkundrak@v3.sk>
References: <1364135511-26970-1-git-send-email-lkundrak@v3.sk>
 <1364451124-5039-1-git-send-email-lkundrak@v3.sk>
Message-ID: <515A44B4.7070903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2013 12:12 AM, Lubomir Rintel wrote:
> This adds a device tree binding for random number generator present on Broadcom
> BCM2835 SoC, used in Raspberry Pi and Roku 2 devices.

FYI, I intend to apply this patch to the bcm2835 tree whenever the RNG
driver itself is applied to the hw_random tree. If you could ping me
when that happens to jog my memory, that'd be great. Thanks.
