From: sw.youn@samsung.com (Seungwhan Youn)
Date: Tue, 12 Oct 2010 20:19:59 +0900
Subject: [PATCH v2 0/6] Add S/PDIF common driver for Samsung SoCs
Message-ID: <1286882399-27595-1-git-send-email-sw.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch-set is a 2nd version for new S/PDIF common driver that supports
S/PDIF PCM audio on S5PC100, S5PC110 and S5PV210.

This patch-set is based on two different branches that :-
 o ARM patches are based on Kukjin Kim's git branch 'for-next'
   (commit id - 64dcc6aef86593e478cf297a8508e55b54cceaf8)
 o ASoC patches are based on Mark Brown's git branch 'for-next'
   (commit id - fe3e2e7ff2da41bd7a985c4c206e05a95ebe7a6b)

This patch-set updates followings from the 1st submit :-
 o Add EPLL enable and get_rate function as common EPLL function
 o Add EPLL rate change warning
 o Fix S/PDIF's audio clock divider set dynamically at CPU driver
 o Move S/PDIF specific register macros and structure into CPU driver

This patch-set contains followings :-
 o To Kukjin Kim and Ben Dooks,
  - [PATCH v2 1/6] ARM: S5P: Reduce duplicated EPLL control codes
  - [PATCH v2 2/6] ARM: S5PV210: Fix wrong EPLL rate getting on setup clocks
  - [PATCH v2 3/6] ARM: S5PV210: Add EPLL clock operations
  - [PATCH v2 4/6] ARM: S5P: Add EPLL rate change warning
 o To Jassi Brar, Mark Brown and Liam Girdwood,
  - [PATCH v2 5/6] ASoC: SAMSUNG: Add S/PDIF CPU driver
  - [PATCH v2 6/6] ASoC: SAMSUNG: Add Machine driver for S/PDIF PCM audio


Best Regards,
Claude(Seungwhan Youn)
