From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon,  5 Jul 2010 21:17:48 +0900
Subject: [PATCH v3] Add support HSMMC on Samsung SMDKV210
Message-ID: <1278332270-25178-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support hsmmc on SMDKV210.

Changes since v2:

- Moved some codes for support hsmmc3 on smdkv210 to second patch

Changes since v1:

- Fixed wrong pin name in comments
- Adding missed call s5pv210_default_sdhci3() in s5pv210_map_io()
- Minor coding style fixes

[PATCH v3 1/2] ARM: SAMSUNG: Add device definition for HSMMC3
[PATCH v3 2/2] ARM: S5PV210: Add support HSMMC on SMDKV210
