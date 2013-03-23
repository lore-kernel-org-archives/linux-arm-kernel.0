From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 23 Mar 2013 18:08:59 +0000
Subject: [PATCH 0/3] arm: orion5x: devicetree fixups and additions
Message-ID: <1364062142-28117-1-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixups and additional DT bindings for orion5x.

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>

Alexander Clouter (3):
  arm: orion5x: fix orion5x.dtsi gpio parameters
  arm: orion5x: add ehci bindings to dtsi
  arm: orion5x: enable xor for orion5x platform

 arch/arm/boot/dts/orion5x.dtsi |   38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

-- 
1.7.10.4
