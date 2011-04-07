From: sbkim73@samsung.com (Sangbeom Kim)
Date: Thu,  7 Apr 2011 09:31:07 +0900
Subject: [PATCH 0/3] Add WM8580 PCM Machine driver for Samsung SoCs
Message-ID: <1302136270-28776-1-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset is for WM8580 pcm machine driver that supports
PCM audio on SMDKC110, SMDKV210, SMDK6450, SMDK6440.
and It is tested on SMDKC110, SMDKV210, SMDKV6450.

Based on these patches WM8580 pcm machine driver supports followings:
 o Playback supports 8kHz sampling rates.
 o Capture supports 8kHz sampling rates.

This patchset contains followings 

 o To Kukjin Kim and Ben Dooks,
[PATCH 1/3] ARM: S5PV210: Add PCM audio support for WM8580
[PATCH 2/3] ARM: S5P64X0: Add PCM audio support for WM8580

 o To Jassi Brar, Mark Brown and Liam Girdwood,
[PATCH 3/3] ASoC: SAMSUNG: Add WM8580 PCM Machine driver 

This patch-set is based on 2.6.39-rc1
and WM8580 machine driver is originated by Seungwhan Youn.

Best Regards,
SB Kim (Sangbeom Kim)
