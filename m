From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Aug 2015 20:04:36 -0600
Subject: [PATCH v2 7/7] ARM: bcm2835: Add VC4 to the device tree.
In-Reply-To: <1439934848-7196-8-git-send-email-eric@anholt.net>
References: <1439934848-7196-1-git-send-email-eric@anholt.net>
 <1439934848-7196-8-git-send-email-eric@anholt.net>
Message-ID: <55DD1EB4.9000401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18/2015 03:54 PM, Eric Anholt wrote:
> VC4 is the GPU (display and 3D) present on the 2835.

This patch and patch 1 seem OK to me, although I'll withhold any ack
until the DT binding design discussion with Rob has been resolved. I
haven't looked at the OF graph bindings he mentioned so have no clue
about his suggestions.
