From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Feb 2015 12:08:33 -0700
Subject: [PATCH] ARM: bcm2835: Add header file for pinctrl constants
In-Reply-To: <1424624396-812-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1424624396-812-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Message-ID: <54EB7AB1.5060200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/22/2015 09:59 AM, Charles Keepax wrote:
> This patch adds a header file for the constants used in pincontrol
> configuration for the bcm2835.

This seems like a duplicate of the following series:

https://lkml.org/lkml/2015/1/16/402
[PATCH 0/4] ARM: bcm2835: DT improvements
[PATCH 1/4] dt-bindings: Add vendor prefix for Raspberry Pi
[PATCH 2/4] dt-bindings: Add root properties for Raspberry Pi B and B+
[PATCH 3/4] ARM: bcm2835: Add header file for pinctrl constants

https://lkml.org/lkml/2015/1/16/405
[PATCH 4/4] ARM: bcm2835: Use pinctrl header

Lee, are you planning on applying one/both/some of these?
