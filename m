From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 7 Nov 2018 14:08:10 +0100
Subject: [PATCH V3] arm64: dts: r8a77990: ebisu: Add and enable SDHI
 device nodes
In-Reply-To: <7154affe-751a-7cb4-48ea-3d4d6f467ac8@gmail.com>
References: <20181106204647.18051-1-marek.vasut+renesas@gmail.com>
 <20181107085056.GB31092@kunai>
 <7154affe-751a-7cb4-48ea-3d4d6f467ac8@gmail.com>
Message-ID: <20181107130810.GA18223@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Nope. I tried that patchset on M3N again yesterday and got error -84
> while initing the eMMC, so I need to look into that first. Then I'll
> try it on E3.

Hmmm, we tried M3N at the hackfest and it worked great there.

First idea: are you sure you have all depending patch series applied as
well?

@Niklas: Have you/can you push a publich branch out with everything
included.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181107/88a706b1/attachment.sig>
