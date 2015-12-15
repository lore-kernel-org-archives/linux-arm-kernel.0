From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 15 Dec 2015 17:38:01 +0100
Subject: [PATCH 0/2] Dove GPU support
Message-ID: <1450197483-31441-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dove maintainers,

those 2 patches add support for the Vivante GPU. The binding has already been
acked by the DT maintainers and is included in the pull request for the DRM
driver. I hope you can pick those patches up for inclusion in 4.5.

Regards,
Lucas

Russell King (2):
  ARM: dts: dove: add DT GPU support
  ARM: dts: enable GPU for SolidRun's Cubox

 arch/arm/boot/dts/dove-cubox.dts |  8 ++++++++
 arch/arm/boot/dts/dove.dtsi      | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

-- 
2.6.2
