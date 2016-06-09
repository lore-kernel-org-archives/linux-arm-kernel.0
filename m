From: kieran@bingham.xyz (Kieran Bingham)
Date: Thu,  9 Jun 2016 17:56:56 +0100
Subject: [RESEND PATCH 0/2] arm64: dts: r8a7795: Add FCPF and FDP1 device nodes
Message-ID: <1465491418-32752-1-git-send-email-kieran@bingham.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Appologies for the resend, I very cleverly sent this cover letter detailing the
dependencies only to my e-mail address. And I already know the dependencies!

Following two patches are the same, sorry for the noise.

These are dependent upon the FCP bindings from Laurent [0], and the FCPF
update to those bindings from me [1], and of course the bindings for the
FDP1 [2] which are all posted separately.

[0] http://www.spinics.net/lists/devicetree/msg123968.html
[1] https://lkml.org/lkml/2016/6/9/291
[2] https://lkml.org/lkml/2016/6/9/294

Kieran Bingham (2):
  arm64: dts: r8a7795: add FCPF device nodes
  arm64: dts: r8a7795: add FDP1 device nodes

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 48 ++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

-- 
2.7.4
