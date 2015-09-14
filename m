From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 14 Sep 2015 14:42:11 +0800
Subject: [PATCH RESEND 0/2] arm: dts: berlin: use stdout-path
Message-ID: <1442212933-760-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two simple patches use stdout-path to specify the console.
The first patch add aliases for serial uarts. The second patch
removes the console argument from the command line, uses stdout-path
instead.

Jisheng Zhang (2):
  arm: dts: berlin: add aliases for serial
  arm: dts: berlin: use stdout-path

 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts        | 3 ++-
 arch/arm/boot/dts/berlin2.dtsi                    | 6 ++++++
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts | 3 ++-
 arch/arm/boot/dts/berlin2cd.dtsi                  | 5 +++++
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts        | 3 ++-
 arch/arm/boot/dts/berlin2q.dtsi                   | 5 +++++
 6 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.5.1
