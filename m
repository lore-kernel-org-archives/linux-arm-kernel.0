From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 27 Feb 2016 22:26:55 +0100
Subject: [PATCH RFC 0/2] pxa3xx devicetree support
Message-ID: <1456608417-13514-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've been baking this for a moment now. It's time to have more eyes on it.

I'm targetting to submit 1/2 as a real patch, with modifications if someone
finds a better way.

I'll probably submit 2/2 one day, but I expect a massive rework on the sound
part as discussed with Mark Brown about AC97 rework, that's the reason I'm
holding it for now. It's here mainly to show application of 1/2.

Any rework ideas would be appreciated.

Cheers.

--
Robert

Robert Jarzmik (2):
  ARM: dts: pxa3xx: add pincontrol helpers
  ARM: dts: pxa: add zylonite devicetree board

 arch/arm/boot/dts/pxa3xx.dtsi     |  90 +++++
 arch/arm/boot/dts/zylonite310.dts | 682 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 772 insertions(+)
 create mode 100644 arch/arm/boot/dts/zylonite310.dts

-- 
2.1.4
