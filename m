From: kieran@bingham.xyz (Kieran Bingham)
Date: Thu, 30 Jun 2016 14:32:41 +0100
Subject: [PATCH v2 0/2] arm64: dts: r8a7795: FCPF and FDP1 device nodes
Message-ID: <1467293563-940-1-git-send-email-kieran@bingham.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Here is my updated series for the dts updates in relation to the RCar/FDP1.

The fcpf patch has collected a reviewed-by from Geert, whilst the fdp1
patch has collected a reviewed by from both Laurent and Geert, with a
small change to remove the labels, as they will not be referenced.

You responded to my previous set for these with the following comment:

> These patches look good to me. My assumption is that they
> can be applied without causing any breakage and that the
> relevant features will start working once driver support
> shows up in the kernel.
> 
> If the above assumption is correct then please let me know when the
> bindings have been accepted by the relevant subsystem maintainer(s).
> 
> If the patches need rebasing at that time then please repost them.
> Otherwise you can either repost them or ping me as a response to this thread.

Your assumption was correct, and they could be applied without breakage.

RobH has acked the binding for the RCar FCPF, but I have not seen an ack for
the FDP1 binding yet. I'll follow that up, and ping you on the fdp1 dts patch
when it resolved.

Regards

Kieran

--

Kieran Bingham (2):
  arm64: dts: r8a7795: add FCPF device nodes
  arm64: dts: r8a7795: add FDP1 device nodes

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 48 ++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

-- 
2.7.4
