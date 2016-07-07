From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 7 Jul 2016 14:19:51 +0100
Subject: [GIT PULL v2] arm64: dts: juno updates for v4.8
In-Reply-To: <5768019C.40009@arm.com>
References: <5768019C.40009@arm.com>
Message-ID: <577E56F7.1010000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

Please pull Juno platform DT updates for v4.8

--
Regards,
Sudeep

v1->v2:
	- Updated with Olof suggestions on one of the patch
	  (arm64: dts: juno: add coresight support)

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git 
tags/juno-dt-4.8

for you to fetch changes up to f7b636a8d83c7c1285c55248e35458e03a007df3:

   arm64: dts: juno: add thermal zones for scpi sensors (2016-06-21 
15:17:31 +0100)

----------------------------------------------------------------
ARMv8 Vexpress/Juno DT updates for v4.8

1. Adds various CoreSight debug components on Juno boards

2. Adds SCPI device power domains and use them for coresight components

3. Adds thermal zones for SCPI sensors on Juno

----------------------------------------------------------------
Javi Merino (1):
       arm64: dts: juno: add thermal zones for scpi sensors

Sudeep Holla (2):
       arm64: dts: juno: add coresight support
       arm64: dts: juno: add SCPI power domains for device power management

  arch/arm64/boot/dts/arm/juno-base.dtsi | 357 
+++++++++++++++++++++++++++++++++
  arch/arm64/boot/dts/arm/juno-r1.dts    |  40 ++++
  arch/arm64/boot/dts/arm/juno-r2.dts    |  40 ++++
  arch/arm64/boot/dts/arm/juno.dts       |  24 +++
  4 files changed, 461 insertions(+)
