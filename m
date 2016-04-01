From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 31 Mar 2016 20:04:57 -0600
Subject: [PATCH 1/3] ARM: multi_v7_defconfig: Add more BCM2835 support
In-Reply-To: <1459470504-5007-1-git-send-email-eric@anholt.net>
References: <1459470504-5007-1-git-send-email-eric@anholt.net>
Message-ID: <56FDD749.3070001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/2016 06:28 PM, Eric Anholt wrote:
> The WDT is required for reboot and I2S is used for audio devices on
> the P5 header (or BT audio on the Pi3).

Patches 1 and 3,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
