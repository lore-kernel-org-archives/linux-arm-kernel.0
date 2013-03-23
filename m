From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 23 Mar 2013 22:29:53 +0000
Subject: [PATCHv2 0/4] arm: orion5x: devicetree fixups and additions
Message-ID: <1364077797-21206-1-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixups and additional DT bindings for orion5x.

Changelog:
 v2 - included descriptions to patches
    - added 'correct IRQ used in dtsi for mv_cesa' patch

Alexander Clouter (4):
  arm: orion5x: fix orion5x.dtsi gpio parameters
  arm: orion5x: add ehci bindings to dtsi
  arm: orion5x: enable xor for orion5x platform
  arm: orion5x: correct IRQ used in dtsi for mv_cesa

 arch/arm/boot/dts/orion5x.dtsi |   40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

-- 
1.7.10.4
