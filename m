From: dhdang@apm.com (Duc Dang)
Date: Sun, 14 Feb 2016 11:13:21 -0800
Subject: [GIT PULL] arm64: X-Gene platforms DTS changes queued for v4.6 - part1
Message-ID: <CADaLNDk3n3WQyRZ3rCwDQBhT4QDAycTaqhSbe4P4MMhxUxCdUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Resend in plain text format]

Hi Arnd, Olof,

This is the first part of DT changes for X-Gene platforms queued for
4.6. This includes only 1 change in compatible string for X-Gene v2
SOC PLL.

Regards,
Duc Dang.
-------

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  https://github.com/AppliedMicro/xgene-next.git tags/xgene-dts-for-v4.6-part1

for you to fetch changes up to a8618b52bca015be7ae342423ba9b6d2e9a8037b:

  arm64: Update Merlin DT PCP PLL clock node for v2 hardware
(2016-02-09 18:25:02 -0800)

----------------------------------------------------------------
First part of X-Gene DT changes queued for v4.6

This includes a change in compatible string of
X-Gene v2 SOC PLL DT node to reflect the v2 hardware.
This change is part of Loc's series
http://www.spinics.net/lists/arm-kernel/msg475481.html

----------------------------------------------------------------
Loc Ho (1):
      arm64: Update Merlin DT PCP PLL clock node for v2 hardware

 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
