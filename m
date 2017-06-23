From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 23 Jun 2017 16:03:22 +0100
Subject: [GIT PULL v2] CCN driver fixes for 4.13
In-Reply-To: <1498229290.6830.11.camel@arm.com>
References: <1498228494.6830.8.camel@arm.com>
 <CAK8P3a2wKDThMvqivHAENhjZCoOOhyrohZqMQx8xboESgomu2Q@mail.gmail.com>
 <1498229290.6830.11.camel@arm.com>
Message-ID: <1498230202.6830.14.camel@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

As discussed - the CCN driver fixes for 4.13 (thirteen), rebased on
v4.12-rc1.Please consider pulling:

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

? Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

? git://git.linaro.org/people/pawel.moll/linux.git tags/ccn/fixes-for-4.13-v2

for you to fetch changes up to 2941be2166c2146ded1d1806ae76e78c26b8d4fe:

? bus: arm-ccn: Enable stats for CCN-502 interconnect (2017-06-23 15:46:38 +0100)

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
