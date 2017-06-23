From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 23 Jun 2017 15:34:54 +0100
Subject: [GIT PULL] CCN drivers fixes for 4.13
Message-ID: <1498228494.6830.8.camel@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

I've got a small series of fixes for the CCN driver. A long belated
one... Apologies to all authors for delaying it way over any sensible
time frame!

If possible, they could go in for 4.13, they are pretty small and
independent from anything else.

Please consider pulling:

The following changes since commit 41f1830f5a7af77cf5c86359aba3cbd706687e52:

? Linux 4.12-rc6 (2017-06-19 22:19:37 +0800)

are available in the git repository at:

? git://git.linaro.org/people/pawel.moll/linux.git tags/ccn/fixes-for-4.13

for you to fetch changes up to e65585fdef23e29b0a7a007a7ec96030f02962d3:

? bus: arm-ccn: Enable stats for CCN-502 interconnect (2017-06-20 11:24:02 +0100)

----------------------------------------------------------------
bus: ARM CCN PMU driver updates

* Fixed missing module aliases, thus autoloading.
* Use appropriate (c)allocation function for arrays of structures.
* Add compatibility string (thus support) for CCN-502 variant.

----------------------------------------------------------------
Javier Martinez Canillas (1):
??????bus: arm-ccn: Fix module autoload

Markus Elfring (1):
??????bus: arm-ccn: Use devm_kcalloc() in arm_ccn_probe()

Velibor Markovski (2):
??????dt-bindings: arm-ccn: Add bindings info for CCN-502 compatible string
??????bus: arm-ccn: Enable stats for CCN-502 interconnect

?Documentation/devicetree/bindings/arm/ccn.txt |??1 +
?drivers/bus/arm-ccn.c?????????????????????????| 10 ++++++----
?2 files changed, 7 insertions(+), 4 deletions(-)
